import 'package:flutter_blo/bloc/posts/bloc/posts_event.dart';
import 'package:flutter_blo/bloc/posts/bloc/posts_state.dart';
import 'package:flutter_blo/repository/post_repository.dart';
import 'package:flutter_blo/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsBloc extends Bloc<PostsEvent, PostsState> {
  PostRepository postRepository = PostRepository();
  PostsBloc() : super(const PostsState()) {
    on<PostFetched>(_fetchPost);
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
}
