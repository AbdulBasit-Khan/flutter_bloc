import 'package:flutter/material.dart';
import 'package:flutter_blo/bloc/posts/bloc/posts_bloc.dart';
import 'package:flutter_blo/bloc/posts/bloc/posts_event.dart';
import 'package:flutter_blo/bloc/posts/bloc/posts_state.dart';
import 'package:flutter_blo/utils/enums.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class PostsScreen extends StatefulWidget {
  const PostsScreen({super.key});

  @override
  State<PostsScreen> createState() => _PostsScreenState();
}

class _PostsScreenState extends State<PostsScreen> {
  @override
  void initState() {
    super.initState();
    context.read<PostsBloc>().add(PostFetched());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Post APIs"),
      ),
      body: BlocBuilder<PostsBloc, PostsState>(builder: (context, state) {
        switch (state.postStatus) {
          case PostStatus.loading:
            return const Center(child: CircularProgressIndicator());
          case PostStatus.failure:
            return Center(child: Text(state.message));
          case PostStatus.success:
            return Column(
              children: [
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 8),
                  child: TextFormField(
                    decoration: const InputDecoration(
                        hintText: "Search with Email",
                        border: OutlineInputBorder()),
                    onChanged: (val) {
                      context.read<PostsBloc>().add(SearchItem(val));
                    },
                  ),
                ),
                Expanded(
                  child: ListView.builder(
                      itemCount: state.tempPostsList.isEmpty
                          ? state.postsList.length
                          : state.tempPostsList.length,
                      itemBuilder: (context, index) {
                        if (state.tempPostsList.isEmpty) {
                          final item = state.postsList[index];

                          return Card(
                            child: ListTile(
                              title: Text(
                                item.email.toString(),
                              ),
                              subtitle: Text(item.body.toString()),
                            ),
                          );
                        } else {
                          final item = state.tempPostsList[index];

                          return Card(
                            child: ListTile(
                              title: Text(
                                item.email.toString(),
                              ),
                              subtitle: Text(item.body.toString()),
                            ),
                          );
                        }
                      }),
                ),
              ],
            );
        }
      }),
    );
  }
}
