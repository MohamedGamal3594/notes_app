import 'package:bloc/bloc.dart';
import 'package:notes_app/models/note_model.dart';

abstract class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial()) {
    loadNotes();
  }

  Future addNote(String id, String title, String subTitle, String date);
  Future deleteNote(NoteModel note);
  Future updateNote(NoteModel note, String title, String subTitle);
  Future loadNotes();
}

abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoaded extends NotesState {
  final List<NoteModel> notes;
  NotesLoaded(this.notes);
}
