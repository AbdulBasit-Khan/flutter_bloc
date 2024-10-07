import 'package:equatable/equatable.dart';
import 'package:flutter_blo/model/favourite_item_model.dart';

enum ListStatus { loading, success, failure }

class FavouriteAppState extends Equatable {
  final List<FavouriteItemModel> favouriteItemList;
  final ListStatus listStatus;
  const FavouriteAppState(
      {this.listStatus = ListStatus.loading,
      this.favouriteItemList = const []});
  FavouriteAppState copyWith(
      {List<FavouriteItemModel>? favouriteItemList, ListStatus? listStatus}) {
    return FavouriteAppState(
      favouriteItemList: favouriteItemList ?? this.favouriteItemList,
      listStatus: listStatus ?? this.listStatus,
    );
  }

  @override
  List<Object?> get props => [favouriteItemList, listStatus];
}
