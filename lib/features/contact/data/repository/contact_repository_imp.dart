import 'package:portfolio/features/contact/data/data_source/contact_remote_data_source.dart';
import 'package:portfolio/features/contact/domain/repository/contact_repository.dart';

class ContactRepositoryImp implements ContactRepository {
  ContactRepositoryImp(this._remoteDataSource);

  final ContactRemoteDataSource _remoteDataSource;

  @override
  Future<void> submitMessage({
    required String name,
    required String email,
    required String phone,
    required String message,
  }) {
    return _remoteDataSource.submitMessage(
      name: name,
      email: email,
      phone: phone,
      message: message,
    );
  }
}
