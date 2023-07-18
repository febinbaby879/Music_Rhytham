// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recentplayed_bloc.dart';

class RecentplayedEvent {}

class GetFecent extends RecentplayedEvent {}

class FetchRecent extends RecentplayedEvent {
  List<Songs> recentlist;
  FetchRecent({
    required this.recentlist,
  });
}
