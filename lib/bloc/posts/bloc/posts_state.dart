import 'package:equatable/equatable.dart';
import 'package:flutter_blo/model/posts_model.dart';
import 'package:flutter_blo/utils/enums.dart';

class PostsState extends Equatable {
  final PostStatus postStatus;
  final List<PostModel> postsList;
  final List<PostModel> tempPostsList;
  final String message;
  final String searchMessage;
  const PostsState({
    this.postStatus = PostStatus.loading,
    this.postsList = const <PostModel>[],
    this.tempPostsList = const <PostModel>[],
    this.message = '',
    this.searchMessage = '',
  });
  PostsState copyWith(
      {PostStatus? postStatus,
      List<PostModel>? postsList,
      String? message,
      String? searchMessage,
      List<PostModel>? tempPostsList}) {
    return PostsState(
        postsList: postsList ?? this.postsList,
        tempPostsList: tempPostsList ?? this.tempPostsList,
        postStatus: postStatus ?? this.postStatus,
        searchMessage: searchMessage ?? this.searchMessage,
        message: message ?? this.message);
  }

  @override
  List<Object?> get props =>
      [postStatus, postsList, message, tempPostsList, searchMessage];
}
