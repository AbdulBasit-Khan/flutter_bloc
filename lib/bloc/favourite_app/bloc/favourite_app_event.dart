import 'package:equatable/equatable.dart';

abstract class FavouriteAppEvent extends Equatable {
  const FavouriteAppEvent();
  @override
  List<Object?> get props => [];
}

class FetchFavouriteList extends FavouriteAppEvent {}
