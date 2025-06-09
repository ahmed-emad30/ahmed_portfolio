part of 'home_cubit.dart';

sealed class HomeState extends Equatable {
  const HomeState();
}

final class HomeInitialState extends HomeState {
  const HomeInitialState();
  
  @override
  List<Object> get props => [];
}
