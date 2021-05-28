import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/data/locales.dart';
import 'package:flutter_architecture/common/data/preferences_keys.dart';
import 'package:flutter_architecture/common/styles/themes.dart';
import 'package:flutter_architecture/data/prefs/app_shared_prefs.dart';
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

class FlutterArchApp extends StatefulWidget {
  @override
  _FlutterArchAppState createState() => _FlutterArchAppState();
}

class _FlutterArchAppState extends State<FlutterArchApp> {
  final NavigationManager _navigationManager =
      di.serviceLocator.get<NavigationManager>();
  var isDarkMode = false;

  @override
  void initState() {
    getPrefs()
        .getBoolean(BOOL_PREFS_KEY_IS_THEME_DARK, false)
        .then((bool value) {
      setState(() {
        isDarkMode = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Architecture Demo',
      initialRoute: _navigationManager.initialRoute,
      routes: _navigationManager.initializeNavigationRoutes(
        context,
        onToggleTheme: () {
          getPrefs()
              .saveBoolean(BOOL_PREFS_KEY_IS_THEME_DARK, !isDarkMode)
              .then((bool value) {
            setState(() {
              isDarkMode = !isDarkMode;
            });
          });
        },
      ),
      theme: isDarkMode ? darkTheme : lightTheme,
      darkTheme: darkTheme,
      themeMode: ThemeMode.system,
    );
  }

  AppSharedPreferences getPrefs() =>
      di.serviceLocator.get<AppSharedPreferences>();
}
