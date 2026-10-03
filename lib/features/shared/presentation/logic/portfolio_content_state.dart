part of 'portfolio_content_cubit.dart';

sealed class PortfolioContentState extends Equatable {
  const PortfolioContentState();

  PortfolioDataEntity get data;

  @override
  List<Object?> get props => [];
}

final class PortfolioContentLoaded extends PortfolioContentState {
  const PortfolioContentLoaded(this.data);

  @override
  final PortfolioDataEntity data;

  @override
  List<Object?> get props => [data];
}
