import 'package:flutter_architecture/common/base/page_cubit.dart';
import 'package:flutter_architecture/common/base/page_state.dart';
import 'package:flutter_architecture/domain/model/base/api_resource.dart';
import 'package:flutter_architecture/domain/model/base/status.dart';
import 'package:flutter_architecture/domain/model/post/post.dart';
import 'package:flutter_architecture/domain/usecase/get_posts_usecase.dart';

part 'post_list_state.dart';

class PostListCubit extends PageCubit<PostListState> {
  final GetPostsUseCase _getPostsUseCase;

  PostListCubit(this._getPostsUseCase) : super(PostListInitialState());

  void getPostList() {
    _getPostsUseCase.execute(null).listen((ApiResource<List<Post>> event) {
      switch (event.status) {
        case Status.LOADING:
          emit(PostListLoadingState());
          break;

        case Status.SUCCESS:
          if (event.data == null || (event.data?.isEmpty == true)) {
            emit(PostListNoDataState());
          } else {
            emit(PostListDataReceivedState(event.data!));
          }
          break;

        case Status.ERROR:
          emit(PostListErrorState(event.message!));
      }
    }).onError((e, s) {
      emit(PostListErrorState(e.toString()));
    });
  }
}
