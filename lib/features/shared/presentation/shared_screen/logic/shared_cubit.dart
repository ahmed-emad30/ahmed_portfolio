import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

part 'shared_state.dart';

class SharedCubit extends Cubit<SharedState> {
  SharedCubit() : super(const SharedInitialState());
}
