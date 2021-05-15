import 'package:flutter_architecture/di.dart';
import 'package:flutter_architecture/navigation/manager.dart';
import 'package:flutter_architecture/navigation/routes.dart';

void registerNavigationModule() {
  serviceLocator.registerSingleton<NavigationManager>(
    NavigationManagerImpl(NavigationRoutes.PLANT_LIST),
  );
}
