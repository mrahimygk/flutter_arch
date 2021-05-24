import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/data/locales.dart';
import 'package:flutter_architecture/navigation/manager.dart';

import 'di.dart' as di;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await EasyLocalization.ensureInitialized();

  await di.loadDiModules();
  runApp(EasyLocalization(
    supportedLocales: appLocaleList.map((e) => e.locale).toList(),
    path: 'assets/translations',
    fallbackLocale: Locale('en'),
    child: FlutterArchApp(),
  ));
}

class FlutterArchApp extends StatelessWidget {
  final NavigationManager _navigationManager =
      di.serviceLocator.get<NavigationManager>();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Architecture Demo',
      initialRoute: _navigationManager.initialRoute,
      routes: _navigationManager.initializeNavigationRoutes(context),
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
    );
  }
}
