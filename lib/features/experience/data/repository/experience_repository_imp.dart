

 import '../../domain/repository/experience_repository.dart' show ExperienceRepository;
import '../data_source/experience_remote_data_source.dart' show ExperienceRemoteDataSource;

class ExperienceRepositoryImp implements ExperienceRepository  {
  ExperienceRepositoryImp(this._remoteDataSource);
 
  final ExperienceRemoteDataSource _remoteDataSource;
}