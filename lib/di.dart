import 'package:flutter_architecture/navigation/di.dart';
import 'package:get_it/get_it.dart';

import 'data/di/api_di.dart';
import 'domain/di/usecase_di.dart';
import 'feature/plants/di.dart';
import 'repository/di.dart';

final serviceLocator = GetIt.I;

Future<void> loadDiModules() async {
  registerApiModule();
  registerRepositoryModule();
  registerUseCaseModule();
  registerNavigationModule();

  registerPlantListPage();
}
