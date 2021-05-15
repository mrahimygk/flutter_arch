import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/base/page_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BaseScreen needs T,S,U
/// T is the Cubit with generic type of ScreenState
/// S is the ScreenState
/// U is the argument type.
abstract class BasePage<T extends Cubit<S>, S extends PageState, U>
    extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  U? args;

  BasePage({Key? key}) : super(key: key);

  T getPageBloc();

  Widget buildPageWidget(BuildContext context);

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as U?;

    return MultiBlocListener(
      listeners: [
        BlocListener<T, S>(
          bloc: getPageBloc(),
          listener: (context, state) {},
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        body: buildPageWidget(context),
      ),
    );
  }
}
