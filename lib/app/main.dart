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
  var isDarkMode = WidgetsBinding.instance?.window.platformBrightness == Brightness.dark;

  @override
  void initState() {
    getPrefs()
        .getBoolean(BOOL_PREFS_KEY_IS_THEME_DARK, WidgetsBinding.instance?.window.platformBrightness == Brightness.dark)
        .then((bool value) {
      setState(() {
        isDarkMode = value;
      });
    });

    WidgetsBinding.instance?.window.onPlatformBrightnessChanged = () {
      final value =
          WidgetsBinding.instance?.window.platformBrightness == Brightness.dark;
      saveThemePrefs(value);
    };
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
          saveThemePrefs(!isDarkMode);
        },
      ),
      theme: isDarkMode ? darkTheme : lightTheme,
    );
  }

  AppSharedPreferences getPrefs() =>
      di.serviceLocator.get<AppSharedPreferences>();

  void saveThemePrefs(bool newValue) {
    getPrefs()
        .saveBoolean(BOOL_PREFS_KEY_IS_THEME_DARK, newValue)
        .then((bool value) {
      setState(() {
        isDarkMode = newValue;
      });
    });
  }
}
