import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'skills_state.dart';

class SkillsCubit extends Cubit<SkillsState> {
  SkillsCubit() : super(const SkillsInitialState());
}
