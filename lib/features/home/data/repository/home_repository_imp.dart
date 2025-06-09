import '../../domain/repository/home_repository.dart';
import '../data_source/home_remote_data_source.dart';

class HomeRepositoryImp implements HomeRepository {
  HomeRepositoryImp(this._remoteDataSource);

  final HomeRemoteDataSource _remoteDataSource;
}
