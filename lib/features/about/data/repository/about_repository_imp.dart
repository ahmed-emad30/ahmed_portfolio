

 import '../../domain/repository/about_repository.dart' show AboutRepository;
import '../data_source/about_remote_data_source.dart' show AboutRemoteDataSource;

class AboutRepositoryImp implements AboutRepository  {
  AboutRepositoryImp(this._remoteDataSource);
 
  final AboutRemoteDataSource _remoteDataSource;
}