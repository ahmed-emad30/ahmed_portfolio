import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app/portfolio_app.dart';
import 'core/helpers/observers/bloc_observer.dart';
import 'core/helpers/shared_preference/preference_helper.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await PrefHelper.init();
  runApp(const PortfolioApp());
}
