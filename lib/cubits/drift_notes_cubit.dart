import 'package:drift/drift.dart';
import 'package:notes_app/cubits/notes_cubit.dart';
import 'package:notes_app/models/drift_database.dart';
import 'package:notes_app/models/drift_note_model.dart';
import 'package:notes_app/models/note_model.dart';

class DriftNoteCubit extends NotesCubit {
  final notesManager = AppDatabase().managers.notes;

  @override
  Future loadNotes() async {
    final notes = await notesManager.get();
    final driftNotes = notes
        .map((note) => DriftNoteModel(
              id: note.id,
              title: note.title,
              subTitle: note.subTitle,
              date: note.date,
            ))
        .toList();
    emit(NotesLoaded(driftNotes));
  }

  @override
  Future addNote(String id, String title, String subTitle, String date) async {
    await notesManager.create(
      (o) => o(
        id: id,
        title: title,
        subTitle: subTitle,
        date: date,
      ),
    );
    loadNotes();
  }

  @override
  Future deleteNote(NoteModel note) async {
    await notesManager
        .filter(
          (f) => f.id.equals(note.id),
        )
        .delete();
    loadNotes();
  }

  @override
  Future updateNote(NoteModel note, String title, String subTitle) async {
    await notesManager
        .filter(
          (f) => f.id.equals(note.id),
        )
        .update(
          (o) => o(
            title: Value(title),
            subTitle: Value(subTitle),
          ),
        );
    loadNotes();
  }
}
