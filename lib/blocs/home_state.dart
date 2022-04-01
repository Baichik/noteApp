part of 'home_bloc.dart';

abstract class HomeState extends Equatable {
  const HomeState({this.count = 0});
  final int count;
  @override
  List<Object?> get props => [];
}

class LoadingHomeState extends HomeState {}

class LoadedHomeState extends HomeState {
  final List<NoteModel> list;

  const LoadedHomeState(this.list);
  @override
  List<Object?> get props => [list];
}

class ErrorHomeState extends HomeState {
  final String errorText;

  const ErrorHomeState(this.errorText);
}
