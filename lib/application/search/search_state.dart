// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'search_bloc.dart';

class SearchState {
  List <Songs> searchlist;
  SearchState({
    required this.searchlist,
  });
}

class SearchInitial extends SearchState {
  SearchInitial() :super(searchlist: []);
}
