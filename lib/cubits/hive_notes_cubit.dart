import 'package:hive_flutter/hive_flutter.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubits/notes_cubit.dart';
import 'package:notes_app/models/hive_note_model.dart';
import 'package:notes_app/models/note_model.dart';

class HiveNotesCubit extends NotesCubit {
  final notesBox = Hive.box<HiveNoteModel>(kNotesBox);

  @override
  Future loadNotes() async {
    emit(NotesLoaded(notesBox.values.toList()));
  }

  @override
  Future addNote(String id, String title, String subTitle, String date) async {
    final hiveNote = HiveNoteModel(
      id: id,
      title: title,
      subTitle: subTitle,
      date: date,
    );
    await notesBox.add(hiveNote);
    loadNotes();
  }

  @override
  Future deleteNote(NoteModel note) async {
    final hiveNote = note as HiveNoteModel;
    await hiveNote.delete();
    loadNotes();
  }

  @override
  Future updateNote(NoteModel note, String title, String subTitle) async {
    final hiveNote = note as HiveNoteModel;
    hiveNote.title = title;
    hiveNote.subTitle = subTitle;
    await hiveNote.save();
    loadNotes();
  }
}
