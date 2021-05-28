import 'package:flutter_architecture/app/di.dart';
import 'package:flutter_architecture/domain/usecase/get_posts_usecase.dart';
import 'package:flutter_architecture/feature/posts/logic/post_list_cubit.dart';

void registerPostListPage() {
  serviceLocator.registerFactory<PostListCubit>(
      () => PostListCubit(serviceLocator.get<GetPostsUseCase>()));
}