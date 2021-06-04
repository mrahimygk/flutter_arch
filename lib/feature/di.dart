import 'package:flutter_architecture/feature/coins/details/rates/di.dart';
import 'package:flutter_architecture/feature/coins/di.dart';
import 'package:flutter_architecture/feature/posts/di.dart';

import 'coins/details/di.dart';

void registerPageModules(){
  registerPostListPage();
  registerCoinListPage();
  registerCoinDetailsPage();
  registerExchangeRatesPage();
}