part of 'about_cubit.dart';

sealed class AboutState extends Equatable {
  const AboutState();
}

final class AboutInitialState extends AboutState {
  const AboutInitialState();
  
  @override
  List<Object> get props => [];
}
