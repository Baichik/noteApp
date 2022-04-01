part of 'home_bloc.dart';

abstract class HomeEvent extends Equatable {
  const HomeEvent();
  @override
  List<Object?> get props => [];
}

class AddHomeEvent extends HomeEvent {
  final NoteModel noteModel;

  const AddHomeEvent(this.noteModel);
}

class UpdateHomeEvent extends HomeEvent {
  final NoteModel noteModel;

  const UpdateHomeEvent(this.noteModel);
}

class DeleteHomeEvent extends HomeEvent {
  final NoteModel noteModel;

  const DeleteHomeEvent(this.noteModel);
}

class FetchHomeEvent extends HomeEvent {}
