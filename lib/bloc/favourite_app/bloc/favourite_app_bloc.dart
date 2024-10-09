import 'dart:developer';

import 'package:flutter_blo/bloc/favourite_app/bloc/favourite_app_event.dart';
import 'package:flutter_blo/bloc/favourite_app/bloc/favourite_app_state.dart';
import 'package:flutter_blo/model/favourite_item_model.dart';
import 'package:flutter_blo/repository/favourite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteAppBloc extends Bloc<FavouriteAppEvent, FavouriteAppState> {
  List<FavouriteItemModel> favouriteList = [];
  List<FavouriteItemModel> tempFavouriteList = [];
  FavouriteRepository favouriteRepository;
  FavouriteAppBloc(this.favouriteRepository)
      : super(const FavouriteAppState()) {
    on<FetchFavouriteList>(fetchList);
    on<FavouriteItem>(addFavouriteItem);
    on<SelectItem>(_selectItem);
    on<UnSelectItem>(_unSelectItem);
  }
  void fetchList(
      FetchFavouriteList event, Emitter<FavouriteAppState> emit) async {
    favouriteList = await favouriteRepository.fetchItem();
    emit(state.copyWith(
        favouriteItemList: List.from(favouriteList),
        listStatus: ListStatus.success));
  }
  void addFavouriteItem(
      FavouriteItem event, Emitter<FavouriteAppState> emit) async {
    final index =
        favouriteList.indexWhere((element) => element.id == event.item.id);
    favouriteList[index] = event.item;
    emit(state.copyWith(favouriteItemList: List.from(favouriteList)));
  }

  void _selectItem(SelectItem event, Emitter<FavouriteAppState> emit) async {
    tempFavouriteList.add(event.item);
    emit(state.copyWith(favouriteItemList: List.from(favouriteList)));
  }

  void _unSelectItem(
      UnSelectItem event, Emitter<FavouriteAppState> emit) async {
    tempFavouriteList.remove(event.item);
    emit(state.copyWith(favouriteItemList: List.from(favouriteList)));
  }
}
