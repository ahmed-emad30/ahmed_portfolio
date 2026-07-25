import 'package:portfolio/features/shared/data/data_source/shared_remote_data_source.dart';
import 'package:portfolio/features/shared/domain/entity/portfolio_data_entity.dart';
import 'package:portfolio/features/shared/domain/repository/shared_repository.dart';

class SharedRepositoryImp implements SharedRepository {
  SharedRepositoryImp(this._remoteDataSource);

  final SharedRemoteDataSource _remoteDataSource;

  @override
  Future<PortfolioDataEntity> getPortfolioData() {
    return _remoteDataSource.fetchPortfolioData();
  }
}
