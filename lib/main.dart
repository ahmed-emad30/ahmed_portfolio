import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/semantics.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_web_plugins/url_strategy.dart';
import 'package:portfolio/core/supabase/supabase_config.dart';
import 'package:portfolio/core/utils/service_locator.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/app/portfolio_app.dart';
import 'core/helpers/observers/bloc_observer.dart';
import 'core/helpers/shared_preference/preference_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  // Hostinger: USE_PATH_URL=true (default). Supabase Storage: USE_PATH_URL=false (hash URLs).
  const usePathUrl = bool.fromEnvironment('USE_PATH_URL', defaultValue: true);
  if (kIsWeb && usePathUrl) {
    usePathUrlStrategy();
  }
  if (kIsWeb) {
    // Flutter web only builds the accessibility tree on request; without it
    // screen readers see an empty canvas.
    SemanticsBinding.instance.ensureSemantics();
  }
  Bloc.observer = MyBlocObserver();
  await PrefHelper.init();
  // Without a backend the site still renders PortfolioContent.fallback.
  if (SupabaseConfig.isConfigured) {
    await Supabase.initialize(
      url: SupabaseConfig.url,
      publishableKey: SupabaseConfig.publishableKey,
      postgrestOptions: const PostgrestClientOptions(
        schema: SupabaseConfig.schema,
      ),
    );
  }
  await ServiceLocator.init();
  runApp(const PortfolioApp());
}
