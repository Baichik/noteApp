import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:note/helpers/dbHelper.dart';
import 'package:note/models/noteModel.dart';

part 'home_event.dart';
part 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final DBHelper dbHelper;
  HomeBloc(this.dbHelper) : super(LoadingHomeState()) {
    dbHelper.initDatabase();
    on<AddHomeEvent>(_addHomeEvent);
    on<UpdateHomeEvent>(_updateHomeEvent);
    on<DeleteHomeEvent>(_deleteHomeEvent);
    on<FetchHomeEvent>(_fetchHomeEvent);
  }

  FutureOr<void> _addHomeEvent(AddHomeEvent event, Emitter<HomeState> emit) {
    try {
      dbHelper.insertNote(event.noteModel);
      add(FetchHomeEvent());
    } catch (e) {
      emit(ErrorHomeState(e.toString()));
    }
  }

  FutureOr<void> _updateHomeEvent(
      UpdateHomeEvent event, Emitter<HomeState> emit) {
    try {
      dbHelper.updateNote(event.noteModel);
      add(FetchHomeEvent());
    } catch (e) {
      emit(ErrorHomeState(e.toString()));
    }
  }

  FutureOr<void> _deleteHomeEvent(
      DeleteHomeEvent event, Emitter<HomeState> emit) {
    try {
      dbHelper.deleteNote(event.noteModel.id!);
      add(FetchHomeEvent());
    } catch (e) {
      emit(ErrorHomeState(e.toString()));
    }
  }

  FutureOr<void> _fetchHomeEvent(
      FetchHomeEvent event, Emitter<HomeState> emit) async {
    try {
      emit(LoadingHomeState());
      final List<NoteModel> list = await dbHelper.getAllNotes();
      emit(LoadedHomeState(list));
    } catch (e) {
      emit(ErrorHomeState(e.toString()));
    }
  }
}
