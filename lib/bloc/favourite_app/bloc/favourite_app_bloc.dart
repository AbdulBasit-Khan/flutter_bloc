import 'package:flutter_blo/bloc/favourite_app/bloc/favourite_app_event.dart';
import 'package:flutter_blo/bloc/favourite_app/bloc/favourite_app_state.dart';
import 'package:flutter_blo/model/favourite_item_model.dart';
import 'package:flutter_blo/repository/favourite_repository.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class FavouriteAppBloc extends Bloc<FavouriteAppEvent, FavouriteAppState> {
  List<FavouriteItemModel> favouriteList = [];
  FavouriteRepository favouriteRepository;
  FavouriteAppBloc(this.favouriteRepository)
      : super(const FavouriteAppState()) {
    on<FetchFavouriteList>(fetchList);
  }
  Future<void> fetchList(
      FetchFavouriteList event, Emitter<FavouriteAppState> emit) async {
    favouriteList = await favouriteRepository.fetchItem();
    emit(state.copyWith(
        favouriteItemList: favouriteList, listStatus: ListStatus.success));
  }
}
