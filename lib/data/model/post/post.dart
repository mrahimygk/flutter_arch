import 'package:json_annotation/json_annotation.dart';

part 'post.g.dart';

@JsonSerializable()
class Post {
  @JsonKey(name: 'id')
  final int id;
  @JsonKey(name: 'userId')
  final int userId;
  @JsonKey(name: 'title')
  final String title;
  @JsonKey(name: 'body')
  final String body;

  Post(
    this.id,
    this.userId,
    this.title,
    this.body,
  );

  factory Post.fromJson(Map<String, dynamic> json) => _$PostFromJson(json);
  Map<String, dynamic> toJson() => _$PostToJson(this);
}
