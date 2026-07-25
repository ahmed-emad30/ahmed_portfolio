sealed class SupabaseConfig {
  static const url = String.fromEnvironment(
    'SUPABASE_URL',
    defaultValue: 'https://tptaqfbmqifzewewnudg.supabase.co',
  );

  /// Prefer publishable key; anon JWT still accepted via the same define for builds.
  static const publishableKey = String.fromEnvironment(
    'SUPABASE_ANON_KEY',
    defaultValue: 'sb_publishable_N2tce2vsArUliYLn9pkxkQ_acu2kZdy',
  );

  static bool get isConfigured => url.isNotEmpty && publishableKey.isNotEmpty;
}
