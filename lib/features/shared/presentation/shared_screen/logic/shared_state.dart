part of 'shared_cubit.dart';

sealed class SharedState extends Equatable {
  const SharedState();
}

final class SharedInitialState extends SharedState {
  const SharedInitialState();
  
  @override
  List<Object> get props => [];
}
