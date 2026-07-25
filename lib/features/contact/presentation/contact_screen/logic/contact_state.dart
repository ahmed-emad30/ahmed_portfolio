part of 'contact_cubit.dart';

sealed class ContactState extends Equatable {
  const ContactState();

  @override
  List<Object?> get props => [];
}

final class ContactInitialState extends ContactState {
  const ContactInitialState();
}

final class ContactSubmittingState extends ContactState {
  const ContactSubmittingState();
}

final class ContactSuccessState extends ContactState {
  const ContactSuccessState();
}

final class ContactFailureState extends ContactState {
  const ContactFailureState(this.message);

  final String message;

  @override
  List<Object?> get props => [message];
}
