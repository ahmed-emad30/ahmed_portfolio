part of 'portfolio_content_cubit.dart';

sealed class PortfolioContentState extends Equatable {
  const PortfolioContentState();

  @override
  List<Object?> get props => [];
}

final class PortfolioContentLoading extends PortfolioContentState {
  const PortfolioContentLoading();
}

final class PortfolioContentLoaded extends PortfolioContentState {
  const PortfolioContentLoaded(this.data, {this.usedFallback = false});

  final PortfolioDataEntity data;
  final bool usedFallback;

  @override
  List<Object?> get props => [data, usedFallback];
}
