
import '../../domain/repository/hero_repository.dart';
import '../data_source/hero_remote_data_source.dart';


 class HeroRepositoryImp implements HeroRepository  {
  HeroRepositoryImp(this._remoteDataSource);
 
  final HeroRemoteDataSource _remoteDataSource;
}