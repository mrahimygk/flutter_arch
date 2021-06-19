import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/common/base/page_state.dart';
import 'package:flutter_architecture/navigation/manager.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

/// BaseScreen needs T,S,U
/// T is the Cubit with generic type of ScreenState
/// S is the ScreenState
/// U is the argument type.
abstract class BasePage<T extends Cubit<S>, S extends PageState, U>
    extends StatelessWidget {
  final _scaffoldKey = GlobalKey<ScaffoldState>();
  final _navigationManager = serviceLocator<NavigationManager>();

  U? args;

  BasePage({Key? key}) : super(key: key);

  T getPageBloc();

  Widget buildWidget(BuildContext context, TextDirection direction, bool isDarkMode);

  @override
  Widget build(BuildContext context) {
    args = ModalRoute.of(context)?.settings.arguments as U?;
    final TextDirection direction = Directionality.of(context);
    final isDarkMode = Theme.of(context).brightness == Brightness.dark;

    return MultiBlocListener(
      listeners: [
        BlocListener<T, S>(
          bloc: getPageBloc(),
          listener: (context, state) {
            if (state is NavigationState) {
              _handleNavigation(context, state);
            }
          },
        ),
      ],
      child: Scaffold(
        key: _scaffoldKey,
        body: buildWidget(context, direction, isDarkMode),
      ),
    );
  }

  void _handleNavigation(BuildContext context, NavigationState state) {
    /**
     * Default is PUSH
     */
    if (state.navigationType == null) {
      _navigationManager.pushNamed(
        context,
        state.destination,
        state.args,
        popUntilName: state.popUntil,
      );
    }
  }
}
