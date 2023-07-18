import 'package:bloc/bloc.dart';
import 'package:moon_walker/domain/Allsongs/model/allSongModel.dart';

part 'search_event.dart';
part 'search_state.dart';

class SearchBloc extends Bloc<SearchEvent, SearchState> {
  SearchBloc() : super(SearchInitial()) {
    on<Search>((event, emit) {
      List<Songs> searchList=[];
      searchList=event.allsongs.where((element) => element.songname!
              .toLowerCase()
              .contains(event.query.toLowerCase().trim()))
          .toList();
          emit(SearchState(searchlist: searchList));
    });
  }
}
