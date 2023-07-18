import 'package:bloc/bloc.dart';
import 'package:moon_walker/domain/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/infrastructure/dbfunc/favourite/fav_func.dart';

part 'favourite_event.dart';
part 'favourite_state.dart';


class FavouriteBloc extends Bloc<FavouriteEvent, FavouriteState> {
  FavouriteBloc() : super(FavouriteInitial()) {

    on<FetchAllFAvourites>((event, emit)async {
     List<Songs> favouriteList= await getFAvourite();
      emit(FavouriteState(favouriteList: favouriteList));
    });

    on<GetFavourite>((event, emit) {
      emit(FavouriteState(favouriteList: event.favouriteList));
    });
  }
}

