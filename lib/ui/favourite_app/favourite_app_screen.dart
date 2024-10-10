import 'package:flutter/material.dart';
import 'package:flutter_blo/bloc/favourite_app/bloc/favourite_app_bloc.dart';
import 'package:flutter_blo/bloc/favourite_app/bloc/favourite_app_event.dart';
import 'package:flutter_blo/bloc/favourite_app/bloc/favourite_app_state.dart';
import 'package:flutter_blo/model/favourite_item_model.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteAppScreen extends StatefulWidget {
  const FavouriteAppScreen({super.key});

  @override
  State<FavouriteAppScreen> createState() => _FavouriteAppScreenState();
}

class _FavouriteAppScreenState extends State<FavouriteAppScreen> {
  @override
  void initState() {
    context.read<FavouriteAppBloc>().add(FetchFavouriteList());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Flutter Bloc"),
          actions: [
            BlocBuilder<FavouriteAppBloc, FavouriteAppState>(
              builder: (context, state) {
                return Visibility(
                  visible:
                      state.tempFavouriteItemList.isNotEmpty ? true : false,
                  child: IconButton(
                      onPressed: () {
                        context.read<FavouriteAppBloc>().add(DeleteItem());
                      },
                      icon: const Icon(
                        Icons.delete,
                        color: Colors.red,
                      )),
                );
              },
            )
          ],
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

                      return Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10),
                        child: Card(
                          child: ListTile(
                            leading: Checkbox(
                                value:
                                    state.tempFavouriteItemList.contains(item),
                                onChanged: (val) {
                                  if (val!) {
                                    context
                                        .read<FavouriteAppBloc>()
                                        .add(SelectItem(item: item));
                                  } else {
                                    context
                                        .read<FavouriteAppBloc>()
                                        .add(UnSelectItem(item: item));
                                  }
                                }),
                            title: Text(item.value.toString()),
                            trailing: IconButton(
                                onPressed: () {
                                  FavouriteItemModel favouriteItemModel =
                                      FavouriteItemModel(
                                          id: item.id,
                                          value: item.value,
                                          isFavourite:
                                              item.isFavourite ? false : true);
                                  context.read<FavouriteAppBloc>().add(
                                      FavouriteItem(item: favouriteItemModel));
                                },
                                icon: Icon(item.isFavourite
                                    ? Icons.favorite
                                    : Icons.favorite_outline)),
                          ),
                        ),
                      );
                    });
            }
          },
        ));
  }
}
