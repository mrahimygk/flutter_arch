import 'package:flutter_architecture/common/base/page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

abstract class PageCubit<T extends PageState> extends Cubit<T> {
  PageCubit(T initialState) : super(initialState);
}
