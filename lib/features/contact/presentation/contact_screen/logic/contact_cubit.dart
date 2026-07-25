import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/features/contact/domain/repository/contact_repository.dart';

part 'contact_state.dart';

class ContactCubit extends Cubit<ContactState> {
  ContactCubit(this._repository) : super(const ContactInitialState());

  final ContactRepository _repository;

  Future<void> submit({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) async {
    emit(const ContactSubmittingState());
    try {
      await _repository.submitMessage(
        name: name.trim(),
        email: email.trim(),
        phone: phone.trim(),
        message: message.trim(),
      );
      emit(const ContactSuccessState());
    } catch (error) {
      emit(ContactFailureState(error.toString()));
    }
  }

  void reset() => emit(const ContactInitialState());
}
