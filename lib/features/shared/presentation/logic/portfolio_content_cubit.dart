import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:portfolio/core/supabase/supabase_config.dart';
import 'package:portfolio/core/utils/portfolio_content.dart';
import 'package:portfolio/features/shared/domain/entity/portfolio_data_entity.dart';
import 'package:portfolio/features/shared/domain/repository/shared_repository.dart';

part 'portfolio_content_state.dart';

/// Renders bundled content immediately, then swaps in Supabase content when it
/// arrives. If the backend is unreachable the bundled content stays on screen.
class PortfolioContentCubit extends Cubit<PortfolioContentState> {
  PortfolioContentCubit(this._repository)
      : super(PortfolioContentLoaded(PortfolioContent.fallback));

  final SharedRepository _repository;

  Future<void> load() async {
    if (!SupabaseConfig.isConfigured) return;
    try {
      final data = await _repository.getPortfolioData();
      emit(PortfolioContentLoaded(data));
    } catch (_) {
      // Keep the bundled content.
    }
  }

  PortfolioDataEntity get data => state.data;
}
