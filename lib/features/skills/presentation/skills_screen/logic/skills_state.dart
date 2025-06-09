part of 'skills_cubit.dart';

sealed class SkillsState extends Equatable {
  const SkillsState();
}

final class SkillsInitialState extends SkillsState {
  const SkillsInitialState();
  
  @override
  List<Object> get props => [];
}
