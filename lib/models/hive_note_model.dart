import 'package:hive/hive.dart';
import 'package:notes_app/models/note_model.dart';

part 'hive_note_model.g.dart';

@HiveType(typeId: 0)
class HiveNoteModel extends HiveObject implements NoteModel {
  @override
  @HiveField(0)
  final String id;
  @override
  @HiveField(1)
  String title;
  @override
  @HiveField(2)
  String subTitle;
  @override
  @HiveField(3)
  final String date;

  HiveNoteModel({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.date,
  });
}
