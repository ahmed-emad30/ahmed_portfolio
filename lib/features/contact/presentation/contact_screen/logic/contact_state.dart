part of 'contact_cubit.dart';

sealed class ContactState extends Equatable {
  const ContactState();
}

final class ContactInitialState extends ContactState {
  const ContactInitialState();
  
  @override
  List<Object> get props => [];
}
