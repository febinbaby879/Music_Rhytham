// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

class SearchEvent {}

class Search extends SearchEvent {
  final String query;
  List<Songs> allsongs;

  Search({
    required this.query,
    required this.allsongs,
  });
}
