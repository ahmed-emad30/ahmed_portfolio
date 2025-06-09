

 import '../../domain/repository/shared_repository.dart' show SharedRepository;
import '../data_source/shared_remote_data_source.dart' show SharedRemoteDataSource;

class SharedRepositoryImp implements SharedRepository  {
  SharedRepositoryImp(this._remoteDataSource);
 
  final SharedRemoteDataSource _remoteDataSource;
}