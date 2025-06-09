

 import '../../domain/repository/skills_repository.dart' show SkillsRepository;
import '../data_source/skills_remote_data_source.dart' show SkillsRemoteDataSource;

class SkillsRepositoryImp implements SkillsRepository  {
  SkillsRepositoryImp(this._remoteDataSource);
 
  final SkillsRemoteDataSource _remoteDataSource;
}