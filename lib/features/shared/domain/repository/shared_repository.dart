import 'package:portfolio/features/shared/domain/entity/portfolio_data_entity.dart';

abstract class SharedRepository {
  Future<PortfolioDataEntity> getPortfolioData();
}
