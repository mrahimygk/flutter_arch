import 'package:flutter_architecture/di.dart';
import 'package:flutter_architecture/repository/posts_repository.dart';
import 'package:flutter_architecture/data/api/posts_api.dart';

void registerRepositoryModule() {
  serviceLocator.registerFactory<PostsRepository>(
      () => PostsRepositoryImpl(serviceLocator.get<PostsApi>()));
}
