part of 'hero_cubit.dart';

sealed class HeroState extends Equatable {
  const HeroState();
}

final class HeroInitialState extends HeroState {
  const HeroInitialState();
  
  @override
  List<Object> get props => [];
}
