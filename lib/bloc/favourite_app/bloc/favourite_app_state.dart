import 'package:equatable/equatable.dart';
import 'package:flutter_blo/model/favourite_item_model.dart';

enum ListStatus { loading, success, failure }

class FavouriteAppState extends Equatable {
  final List<FavouriteItemModel> favouriteItemList;
  final List<FavouriteItemModel> tempFavouriteItemList;
  final ListStatus listStatus;
  const FavouriteAppState({
    this.listStatus = ListStatus.loading,
    this.favouriteItemList = const [],
    this.tempFavouriteItemList = const [],
  });
  FavouriteAppState copyWith(
      {List<FavouriteItemModel>? favouriteItemList,
      List<FavouriteItemModel>? tempFavouriteItemList,
      ListStatus? listStatus}) {
    return FavouriteAppState(
      favouriteItemList: favouriteItemList ?? this.favouriteItemList,
      tempFavouriteItemList:
          tempFavouriteItemList ?? this.tempFavouriteItemList,
      listStatus: listStatus ?? this.listStatus,
    );
  }

  @override
  List<Object?> get props =>
      [favouriteItemList, listStatus, tempFavouriteItemList];
}
