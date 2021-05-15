import 'package:flutter_architecture/common/base/screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class ScreenCubit<T extends ScreenState> extends Cubit<T> {
  ScreenCubit(T initialState) : super(initialState);
}
