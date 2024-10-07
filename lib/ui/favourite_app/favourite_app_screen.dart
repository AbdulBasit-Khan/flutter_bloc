import 'package:flutter/material.dart';
import 'package:flutter_blo/bloc/favourite_app/bloc/favourite_app_bloc.dart';
import 'package:flutter_blo/bloc/favourite_app/bloc/favourite_app_event.dart';
import 'package:flutter_blo/bloc/favourite_app/bloc/favourite_app_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteAppScreen extends StatelessWidget {
  const FavouriteAppScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.read<FavouriteAppBloc>().add(FetchFavouriteList());
          },
          child: const Icon(Icons.add),
        ),
        appBar: AppBar(
          title: const Text("Favourite App"),
        ),
        body: BlocBuilder<FavouriteAppBloc, FavouriteAppState>(
          builder: (context, state) {
            switch (state.listStatus) {
              case ListStatus.loading:
                return const Center(child: CircularProgressIndicator());
              case ListStatus.failure:
                return const Text("Something went wrong");
              case ListStatus.success:
                return ListView.builder(
                    itemCount: state.favouriteItemList.length,
                    itemBuilder: (context, index) {
                      final item = state.favouriteItemList[index];

                      return Card(
                        child: ListTile(
                          title: Text(item.value.toString()),
                        ),
                      );
                    });
            }
          },
        ));
  }
}
