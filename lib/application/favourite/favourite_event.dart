// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'favourite_bloc.dart';

class FavouriteEvent {}

class GetFavourite extends FavouriteEvent {
  List<Songs> favouriteList;
  GetFavourite({
    required this.favouriteList,
  });
}

class FetchAllFAvourites extends FavouriteEvent{}

