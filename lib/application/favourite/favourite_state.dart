// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favourite_bloc.dart';

class FavouriteState {
  List<Songs> favouriteList;
  FavouriteState({
    required this.favouriteList,
  });
}

class FavouriteInitial extends FavouriteState {
  FavouriteInitial() :super(favouriteList: []);
  
}


