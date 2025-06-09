part of 'experience_cubit.dart';

sealed class ExperienceState extends Equatable {
  const ExperienceState();
}

final class ExperienceInitialState extends ExperienceState {
  const ExperienceInitialState();
  
  @override
  List<Object> get props => [];
}
