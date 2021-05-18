import 'package:dio/dio.dart';
import 'package:flutter_architecture/data/model/post/post.dart';
import 'package:retrofit/retrofit.dart';

part 'posts_api.g.dart';

@RestApi()
abstract class PostsApi {
  factory PostsApi(Dio dio, {String? baseUrl}) = _PostsApi;

  @GET("posts/")
  Future<List<Post>> getPosts();

  @GET("posts/{id}/")
  Future<Post> getPostById(@Path("id") int id);
}
