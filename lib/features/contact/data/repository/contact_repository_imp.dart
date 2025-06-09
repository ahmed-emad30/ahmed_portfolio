

 import '../../domain/repository/contact_repository.dart' show ContactRepository;
import '../data_source/contact_remote_data_source.dart' show ContactRemoteDataSource;

class ContactRepositoryImp implements ContactRepository  {
  ContactRepositoryImp(this._remoteDataSource);
 
  final ContactRemoteDataSource _remoteDataSource;
}