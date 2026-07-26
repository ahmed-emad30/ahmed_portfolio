import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/features/shared/domain/entity/portfolio_data_entity.dart';
import 'package:portfolio/features/shared/domain/repository/shared_repository.dart';

part 'portfolio_content_state.dart';

class PortfolioContentCubit extends Cubit<PortfolioContentState> {
  PortfolioContentCubit(this._repository)
      : super(const PortfolioContentLoading());

  final SharedRepository _repository;

  Future<void> load() async {
    emit(const PortfolioContentLoading());
    try {
      final data = await _repository.getPortfolioData();
      emit(PortfolioContentLoaded(data));
    } catch (_) {
      emit(const PortfolioContentLoaded(PortfolioDataEntity.empty));
    }
  }

  PortfolioDataEntity get data {
    final current = state;
    if (current is PortfolioContentLoaded) return current.data;
    return PortfolioDataEntity.empty;
  }
}
