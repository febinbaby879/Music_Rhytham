// ignore_for_file: public_member_api_docs, sort_constructors_first
part of 'nav_bar_bloc.dart';


@immutable
abstract class LandingPageState {
  final int tabIndex;

  const LandingPageState({required this.tabIndex});
}

class LandingPageInitial extends LandingPageState {
  const LandingPageInitial({required super.tabIndex});
}