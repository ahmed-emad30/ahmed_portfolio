

 import '../../domain/repository/services_repository.dart' show ServicesRepository;
import '../data_source/services_remote_data_source.dart' show ServicesRemoteDataSource;

class ServicesRepositoryImp implements ServicesRepository  {
  ServicesRepositoryImp(this._remoteDataSource);
 
  final ServicesRemoteDataSource _remoteDataSource;
}