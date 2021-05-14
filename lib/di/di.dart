
import 'package:flutter_architecture/data/di/api_di.dart';
import 'package:get_it/get_it.dart';

final serviceLocator = GetIt.I;

Future<void> loadDiModules() async {

  registerApiModule();
}k