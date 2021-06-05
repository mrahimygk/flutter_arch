import 'package:flutter/material.dart';
import 'package:flutter_architecture/feature/coins/details/view/coin_details_page.dart';
import 'package:flutter_architecture/feature/coins/list/view/coin_list_page.dart';
import 'package:flutter_architecture/feature/posts/view/post_list_page.dart';
import 'package:flutter_architecture/navigation/routes.dart';

abstract class NavigationManager {
  final String initialRoute;

  NavigationManager(this.initialRoute);

  Map<String, WidgetBuilder> initializeNavigationRoutes(
    BuildContext context, {
    required VoidCallback onToggleTheme,
  });

  Future<Object?> pushNamed(
    BuildContext context,
    String destination,
    dynamic args, {
    String? popUntilName,
  });

  void pop(BuildContext context);

  void pushReplacementNamed(
    BuildContext context,
    String destination,
    dynamic args,
  );

  void popAndPushNamed(
    BuildContext context,
    String destination,
    dynamic args,
  );
}

class NavigationManagerImpl extends NavigationManager {
  NavigationManagerImpl(String initialRoute) : super(initialRoute);

  @override
  Map<String, WidgetBuilder> initializeNavigationRoutes(
    BuildContext context, {
    required VoidCallback onToggleTheme,
  }) =>
      {
        NavigationRoutes.POST_LIST: (context) => PostListPage(onToggleTheme),
        NavigationRoutes.COIN_LIST: (context) => CoinListPage(onToggleTheme),
        NavigationRoutes.COIN_DETAILS: (context) => CoinDetailsPage(onToggleTheme),
      };

  @override
  void pop(BuildContext context) {
    Navigator.of(context, rootNavigator: true).pop();
  }

  @override
  void popAndPushNamed(BuildContext context, String destination, args) {
    Navigator.of(context).popAndPushNamed(destination, arguments: args);
  }

  @override
  void pushReplacementNamed(BuildContext context, String destination, args) {
    Navigator.of(context).pushReplacementNamed(destination, arguments: args);
  }

  @override
  Future<Object?> pushNamed(BuildContext context, String destination, args,
      {String? popUntilName}) {
    if (popUntilName?.trim().isNotEmpty ?? false) {
      return Navigator.pushNamedAndRemoveUntil(
        context,
        destination,
        ModalRoute.withName(destination),
        arguments: args,
      );
    } else {
      return Navigator.pushNamed(context, destination, arguments: args);
    }
  }
}
