-- Portfolio backend, isolated in its own schema inside the shared (active) Supabase project.
--
-- Run once in the target project: Dashboard → SQL Editor → paste → Run.
-- Then: Settings → API → Exposed schemas → add `portfolio`.
--
-- Safe to re-run: every statement is idempotent.

create extension if not exists pgcrypto;

create schema if not exists portfolio;

-- ---------------------------------------------------------------------------
-- Tables
-- ---------------------------------------------------------------------------

create table if not exists portfolio.profile (
  id uuid primary key default gen_random_uuid(),
  display_name text not null,
  title text not null,
  about text not null,
  ae_studio_label text not null default 'AE Studio',
  ae_studio_url text not null default '',
  resume_url text not null default '',
  skills_subtitle text not null default '',
  created_at timestamptz not null default now(),
  updated_at timestamptz not null default now()
);

create table if not exists portfolio.social_links (
  id uuid primary key default gen_random_uuid(),
  key text not null unique,
  url text not null default '',
  sort_order integer not null default 0,
  is_enabled boolean not null default true,
  created_at timestamptz not null default now()
);

create table if not exists portfolio.services (
  id uuid primary key default gen_random_uuid(),
  title text not null,
  description text not null,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists portfolio.skill_categories (
  id uuid primary key default gen_random_uuid(),
  title text not null unique,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists portfolio.skills (
  id uuid primary key default gen_random_uuid(),
  category_id uuid not null references portfolio.skill_categories (id) on delete cascade,
  name text not null,
  proficiency integer not null default 0 check (proficiency between 0 and 100),
  color_hex text,
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create index if not exists skills_category_id_idx on portfolio.skills (category_id);

create table if not exists portfolio.experiences (
  id uuid primary key default gen_random_uuid(),
  role text not null,
  company text not null default '',
  period text not null,
  context text not null default '',
  bullets text[] not null default '{}',
  tech_tags text[] not null default '{}',
  sort_order integer not null default 0,
  created_at timestamptz not null default now()
);

create table if not exists portfolio.projects (
  id uuid primary key default gen_random_uuid(),
  slug text not null unique,
  title text not null,
  short_description text not null default '',
  full_description text not null default '',
  image_url text,
  image_key text,
  tech_stack text[] not null default '{}',
  features text[] not null default '{}',
  role text not null default '',
  sort_order integer not null default 0,
  google_play_url text,
  app_store_url text,
  video_url text,
  github_url text,
  apk_url text,
  web_url text,
  supports_windows boolean not null default false,
  preview_image_1_url text,
  preview_image_1_key text,
  preview_image_2_url text,
  preview_image_2_key text,
  created_at timestamptz not null default now()
);

create table if not exists portfolio.contact_messages (
  id uuid primary key default gen_random_uuid(),
  name text not null check (char_length(name) between 1 and 200),
  email text not null check (char_length(email) between 3 and 320),
  phone text not null default '' check (char_length(phone) <= 50),
  message text not null check (char_length(message) between 1 and 5000),
  created_at timestamptz not null default now()
);

-- ---------------------------------------------------------------------------
-- Row level security
-- ---------------------------------------------------------------------------

alter table portfolio.profile enable row level security;
alter table portfolio.social_links enable row level security;
alter table portfolio.services enable row level security;
alter table portfolio.skill_categories enable row level security;
alter table portfolio.skills enable row level security;
alter table portfolio.experiences enable row level security;
alter table portfolio.projects enable row level security;
alter table portfolio.contact_messages enable row level security;

do $$
declare
  t text;
begin
  foreach t in array array[
    'profile', 'social_links', 'services', 'skill_categories',
    'skills', 'experiences', 'projects'
  ] loop
    execute format('drop policy if exists "public read" on portfolio.%I', t);
    execute format(
      'create policy "public read" on portfolio.%I for select to anon, authenticated using (true)',
      t
    );
  end loop;
end $$;

drop policy if exists "public insert" on portfolio.contact_messages;
create policy "public insert" on portfolio.contact_messages
  for insert to anon, authenticated
  with check (true);

-- ---------------------------------------------------------------------------
-- Grants (new schemas get no API privileges by default)
-- ---------------------------------------------------------------------------

grant usage on schema portfolio to anon, authenticated, service_role;

grant select on
  portfolio.profile,
  portfolio.social_links,
  portfolio.services,
  portfolio.skill_categories,
  portfolio.skills,
  portfolio.experiences,
  portfolio.projects
to anon, authenticated;

-- Insert only: visitors can send a message but never read the inbox.
revoke all on portfolio.contact_messages from anon, authenticated;
grant insert (name, email, phone, message) on portfolio.contact_messages to anon, authenticated;

grant all on all tables in schema portfolio to service_role;
alter default privileges in schema portfolio grant all on tables to service_role;
