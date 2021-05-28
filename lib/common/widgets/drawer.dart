import 'package:easy_localization/easy_localization.dart';
import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/data/locales.dart';
import 'package:flutter_architecture/domain/model/locale/app_locale.dart';

class AppDrawer extends StatefulWidget {
  final Function(Locale? locale)? onLanguageChanged;
  final VoidCallback onToggleTheme;

  const AppDrawer({
    Key? key,
    this.onLanguageChanged,
    required this.onToggleTheme,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => AppDrawerState(
        onToggleTheme: onToggleTheme,
        onLanguageChanged: onLanguageChanged,
      );
}

class AppDrawerState extends State<AppDrawer> {
  Locale? currentLocale;
  bool isDarkMode = false;

  final Function(Locale? locale)? onLanguageChanged;
  final VoidCallback onToggleTheme;

  AppDrawerState({
    Key? key,
    this.onLanguageChanged,
    required this.onToggleTheme,
  });

  @override
  Widget build(BuildContext context) {
    isDarkMode = Theme.of(context).brightness == Brightness.dark;
    currentLocale = EasyLocalization.of(context)?.currentLocale;
    final items = AppDrawerItems.get();
    return Drawer(
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];
          if (item.type == AppDrawerItems.HEADER) {
            return DrawerHeader(
              child: Container(
                height: 240.0,
                color: Colors.green,
              ),
            );
          }
          if (item.type == AppDrawerItems.LANGUAGE) {
            return ListTile(
              title: Text(items[index].title.tr()),
              trailing: DropdownButton<Locale>(
                value: currentLocale,
                onChanged: (Locale? newValue) {
                  setState(() {
                    currentLocale = newValue;
                    onLanguageChanged?.call(newValue);
                  });
                },
                items: appLocaleList
                    .map<DropdownMenuItem<Locale>>(
                      (AppLocale e) => DropdownMenuItem(
                        child: Text(e.name),
                        value: e.locale,
                      ),
                    )
                    .toList(),
              ),
            );
          }

          if (item.type == AppDrawerItems.DARK_MODE) {
            return ListTile(
                title: Text(items[index].title.tr()),
                trailing: Switch(
                  value: isDarkMode,
                  onChanged: (bool newValue) {
                    onToggleTheme.call();
                  },
                ));
          }

          return ListTile(title: Text(items[index].title.tr()));
        },
      ),
    );
  }
}

abstract class IDrawerItem {
  final String title;
  final int type;

  IDrawerItem(this.title, this.type);
}

class SimpleDrawerItem extends IDrawerItem {
  SimpleDrawerItem(String titleKey, int type) : super(titleKey, type);
}

class DrawerItem extends IDrawerItem {
  DrawerItem(String titleKey, int type) : super(titleKey, type);
}

class AppDrawerItems {
  static const int HEADER = 0;
  static const int LOGIN = 1;
  static const int LANGUAGE = 2;
  static const int DARK_MODE = 3;

  static List<IDrawerItem> get() {
    return [
      DrawerItem("HEADER", HEADER),
      SimpleDrawerItem("login", LOGIN),
      DrawerItem("language", LANGUAGE),
      DrawerItem("darkMode", DARK_MODE),
    ];
  }
}
