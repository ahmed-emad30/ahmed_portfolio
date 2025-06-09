import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'experience_state.dart';

class ExperienceCubit extends Cubit<ExperienceState> {
  ExperienceCubit() : super(const ExperienceInitialState());
}
