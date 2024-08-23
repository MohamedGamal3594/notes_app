import 'package:bloc/bloc.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/models/note_model.dart';

class NotesCubit extends Cubit<NotesState> {
  NotesCubit() : super(NotesInitial()) {
    loadNotes();
  }

  loadNotes() {
    var notesBox = Hive.box<NoteModel>(kNotesBox);
    emit(NotesLoaded(notesBox.values.toList()));
  }

  Future addNote(NoteModel note) async {
    var notesBox = Hive.box<NoteModel>(kNotesBox);
    await notesBox.add(note);
    loadNotes();
  }

  Future deleteNote(NoteModel note) async {
    await note.delete();
    loadNotes();
  }

  Future updateNote(NoteModel note) async {
    await note.save();
    loadNotes();
  }
}

abstract class NotesState {}

class NotesInitial extends NotesState {}

class NotesLoaded extends NotesState {
  final List<NoteModel> notes;
  NotesLoaded(this.notes);
}
