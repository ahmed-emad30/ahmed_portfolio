part of 'portfolio_cubit.dart';

sealed class PortfolioState extends Equatable {
  const PortfolioState();
}

final class PortfolioInitialState extends PortfolioState {
  const PortfolioInitialState();
  
  @override
  List<Object> get props => [];
}
