import 'package:flutter_architecture/di.dart';
import 'package:flutter_architecture/domain/usecase/get_posts_usecase.dart';
import 'package:flutter_architecture/repository/posts_repository.dart';

void registerUseCaseModule() {
  serviceLocator.registerFactory<GetPostsUseCase>(
      () => GetPostsUseCaseImpl(serviceLocator.get<PostsRepository>()));
}
