import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'hero_state.dart';

class HeroCubit extends Cubit<HeroState> {
  HeroCubit() : super(const HeroInitialState());
}
