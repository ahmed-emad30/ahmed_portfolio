import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
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
  if (kIsWeb) {
    usePathUrlStrategy();
  }
  Bloc.observer = MyBlocObserver();
  await PrefHelper.init();
  await Supabase.initialize(
    url: SupabaseConfig.url,
    publishableKey: SupabaseConfig.publishableKey,
  );
  await ServiceLocator.init();
  runApp(const PortfolioApp());
}
