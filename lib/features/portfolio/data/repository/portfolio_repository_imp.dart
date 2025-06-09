

 import '../../domain/repository/portfolio_repository.dart' show PortfolioRepository;
import '../data_source/portfolio_remote_data_source.dart' show PortfolioRemoteDataSource;

class PortfolioRepositoryImp implements PortfolioRepository  {
  PortfolioRepositoryImp(this._remoteDataSource);
 
  final PortfolioRemoteDataSource _remoteDataSource;
}