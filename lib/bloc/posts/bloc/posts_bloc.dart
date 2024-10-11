import 'package:flutter_blo/bloc/posts/bloc/posts_event.dart';
import 'package:flutter_blo/bloc/posts/bloc/posts_state.dart';
import 'package:flutter_blo/model/posts_model.dart';
import 'package:flutter_blo/repository/post_repository.dart';
import 'package:flutter_blo/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  List<PostModel> tempPostsList = [];
  PostRepository postRepository = PostRepository();
  PostsBloc() : super(const PostsState()) {
    on<PostFetched>(_fetchPost);
    on<SearchItem>(_filterList);
  }
  Future<void> _fetchPost(PostFetched event, Emitter<PostsState> emit) async {
    await postRepository.fetchPost().then((val) {
      emit(state.copyWith(
          postStatus: PostStatus.success, message: "success", postsList: val));
    }).onError((error, stackTrace) {
      emit(state.copyWith(
          postStatus: PostStatus.failure, message: error.toString()));
    });
  }

  Future<void> _filterList(SearchItem event, Emitter<PostsState> emit) async {
    if (event.searchText.isEmpty) {
      emit(state.copyWith(tempPostsList: [], searchMessage: ''));
    } else {
      tempPostsList = state.postsList
          .where(
              (element) => element.id.toString() == event.searchText.toString())
          .toList();
      if (tempPostsList.isEmpty) {
        emit(state.copyWith(
            tempPostsList: tempPostsList, searchMessage: 'No Data Found'));
      } else {
        emit(state.copyWith(tempPostsList: tempPostsList, searchMessage: ''));
      }
    }
  }
}
