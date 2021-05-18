part of 'post_list_cubit.dart';

abstract class PostListState extends PageState {
  const PostListState();
}

class PostListInitialState extends PostListState {
  @override
  List<Object?> get props => [];
}

class PostListLoadingState extends PostListState {
  @override
  List<Object?> get props => [];
}

class PostListNoDataState extends PostListState {
  @override
  List<Object?> get props => [];
}

class PostListErrorState extends PostListState {
  final String error;

  PostListErrorState(this.error);

  @override
  List<Object?> get props => [error];
}

class PostListDataReceivedState extends PostListState {
  final List<Post> posts;

  PostListDataReceivedState(this.posts);

  @override
  List<Object?> get props => [posts];

}

//TODO: add navigate state to go to details