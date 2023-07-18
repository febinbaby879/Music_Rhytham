import 'package:bloc/bloc.dart';
import 'package:moon_walker/domain/Allsongs/model/allSongModel.dart';
import 'package:moon_walker/infrastructure/dbfunc/recent/recentdb.dart';

part 'recentplayed_event.dart';
part 'recentplayed_state.dart';

class RecentplayedBloc extends Bloc<RecentplayedEvent, RecentplayedState> {
  RecentplayedBloc() : super(RecentplayedInitial()) {
    on<GetFecent>((event, emit) async{
      List<Songs> recentlist=await recentfetchh();
      emit(RecentplayedState(recentPlayed: recentlist));
    });
    on<FetchRecent>((event, emit) async{
      emit(RecentplayedState(recentPlayed: event.recentlist));
    });
  }
}
