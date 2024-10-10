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
    on<DeleteItem>(_deleteItem);
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
    if (tempFavouriteList.contains(favouriteList[index])) {
      tempFavouriteList.remove(favouriteList[index]);
      tempFavouriteList.add(event.item);
    }
    favouriteList[index] = event.item;
    emit(state.copyWith(
        favouriteItemList: List.from(favouriteList),
        tempFavouriteItemList: List.from(tempFavouriteList)));
  }

  void _selectItem(SelectItem event, Emitter<FavouriteAppState> emit) async {
    tempFavouriteList.add(event.item);
    emit(state.copyWith(tempFavouriteItemList: List.from(tempFavouriteList)));
  }

  void _unSelectItem(
      UnSelectItem event, Emitter<FavouriteAppState> emit) async {
    tempFavouriteList.remove(event.item);
    emit(state.copyWith(tempFavouriteItemList: List.from(tempFavouriteList)));
  }

  void _deleteItem(DeleteItem event, Emitter<FavouriteAppState> emit) async {
    for (int i = 0; i < tempFavouriteList.length; i++) {
      favouriteList.remove(tempFavouriteList[i]);
    }
    tempFavouriteList.clear();
    emit(state.copyWith(
        tempFavouriteItemList: List.from(tempFavouriteList),
        favouriteItemList: List.from(favouriteList)));
  }
}
