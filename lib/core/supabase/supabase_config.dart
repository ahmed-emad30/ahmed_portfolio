sealed class SupabaseConfig {
  /// Active project's API URL. Pass with `--dart-define=SUPABASE_URL=...`.
  static const url = String.fromEnvironment('SUPABASE_URL');

  /// Prefer publishable key; anon JWT still accepted via the same define for builds.
  static const publishableKey = String.fromEnvironment('SUPABASE_ANON_KEY');

  /// Postgres schema holding the portfolio tables inside the shared project.
  static const schema = String.fromEnvironment(
    'SUPABASE_SCHEMA',
    defaultValue: 'portfolio',
  );

  static bool get isConfigured => url.isNotEmpty && publishableKey.isNotEmpty;
}
