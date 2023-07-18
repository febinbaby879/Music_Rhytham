// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'recentplayed_bloc.dart';

class RecentplayedState {
  List<Songs> recentPlayed;
  RecentplayedState({
    required this.recentPlayed,
  });
}

class RecentplayedInitial extends RecentplayedState {
  RecentplayedInitial() :super(recentPlayed: []);
}
