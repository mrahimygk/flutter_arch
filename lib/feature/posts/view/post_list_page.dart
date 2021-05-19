import 'package:flutter/material.dart';
import 'package:flutter_architecture/common/base/base_page.dart';
import 'package:flutter_architecture/common/widgets/api_error_widget.dart';
import 'package:flutter_architecture/common/widgets/drawer.dart';
import 'package:flutter_architecture/di.dart';
import 'package:flutter_architecture/domain/model/post/post.dart';
import 'package:flutter_architecture/feature/posts/logic/post_list_cubit.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:easy_localization/easy_localization.dart';

class PostListPage extends BasePage<PostListCubit, PostListState, void> {
  final PostListCubit _cubit = serviceLocator.get<PostListCubit>();

  PostListPage({Key? key}) : super(key: key){
    _cubit.getPostList();
  }

  @override
  Widget buildPageWidget(BuildContext context) {

    return Scaffold(
      appBar: AppBar(),
      drawer: AppDrawer(),
      body: Column(
        mainAxisSize: MainAxisSize.max,
        children: [
          Text("appName".tr()),
          BlocBuilder(
            bloc: _cubit,
            buildWhen: (previousState, currentState) {
              return previousState != currentState;
            },
            builder: (BuildContext context, PostListState state) {
              if (state is PostListInitialState) {
                return Container(color: Colors.white);
              }

              if (state is PostListLoadingState) {
                return Expanded(child: Center(child: CircularProgressIndicator()));
              }

              if (state is PostListNoDataState) {
                return Text("No data, retry");
              }

              if (state is PostListErrorState) {
                return Padding(
                    padding: const EdgeInsets.all(16.0),
                    child: ApiErrorWidget(state.error, () {
                      _cubit.getPostList();
                    }));
              }

              if (state is PostListDataReceivedState) {
                return Expanded(child: _buildPostListView(state.posts));
              }

              throw Exception("Please handle all states above");
            },
          ),
        ],
      ),
    );
  }

  @override
  PostListCubit getPageBloc() => _cubit;

  Widget _buildPostListView(List<Post> posts) {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          final item  =posts[index];
          return Padding(
            padding: const EdgeInsets.only(top:18.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisSize: MainAxisSize.max,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left:8.0),
                  child: Text("${item.id} :"),
                ),
                Container(
                  width: MediaQuery.of(context).size.width,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: Icon(Icons.message),
                              ),
                              Flexible(child: Text(item.title, style: TextStyle(fontWeight: FontWeight.bold),)),
                            ],
                          ),
                          Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Text(item.body),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          );
        });
  }
}
