import 'package:flutter/cupertino.dart';
import 'package:flutter_architecture/feature/base/screen_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BaseScreen needs T,S,U
/// T is the Cubit with generic type of ScreenState
/// S is the ScreenState
/// U is the argument type.
abstract class BaseScreen<T extends Cubit<S>, S extends ScreenState, U>
    extends StatelessWidget {

  BaseScreen({Key? key}) : super(key: key);


}