part of 'services_cubit.dart';

sealed class ServicesState extends Equatable {
  const ServicesState();
}

final class ServicesInitialState extends ServicesState {
  const ServicesInitialState();
  
  @override
  List<Object> get props => [];
}
