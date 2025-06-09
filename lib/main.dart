import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/app/portfolio_app.dart';
import 'core/helpers/observers/bloc_observer.dart';

void main() {
     Bloc.observer  = MyBlocObserver();
  runApp(const PortfolioApp());
}



