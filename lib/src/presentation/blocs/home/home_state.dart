part of '../home/home_bloc.dart';

@freezed
class HomeState with _$HomeState {
  const factory HomeState.navigationScreenChanged(int selectedIndex) =
      NavigationScreenChanged;
}
