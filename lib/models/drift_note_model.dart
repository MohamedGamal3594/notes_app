import 'package:notes_app/models/note_model.dart';

class DriftNoteModel implements NoteModel {
  @override
  final String id;
  @override
  final String title;
  @override
  final String subTitle;
  @override
  final String date;

  DriftNoteModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.date,
  });
}
