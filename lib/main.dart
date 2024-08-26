import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive_flutter/adapters.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubits/drift_notes_cubit.dart';
import 'package:notes_app/cubits/hive_notes_cubit.dart';
import 'package:notes_app/cubits/notes_cubit.dart';
import 'package:notes_app/models/hive_note_model.dart';
import 'package:notes_app/views/notes_view.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (localDb == LocalDb.hive) {
    await Hive.initFlutter();
    Hive.registerAdapter(HiveNoteModelAdapter());
    await Hive.openBox<HiveNoteModel>(kNotesBox);
  }
  runApp(DevicePreview(
    enabled: !kReleaseMode,
    builder: (context) => const NotesApp(),
  ));
}

class NotesApp extends StatelessWidget {
  const NotesApp({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider<NotesCubit>(
      create: (context) =>
          localDb == LocalDb.hive ? HiveNotesCubit() : DriftNoteCubit(),
      child: MaterialApp(
        locale: DevicePreview.locale(context),
        builder: DevicePreview.appBuilder,
        debugShowCheckedModeBanner: false,
        theme: ThemeData.dark(),
        home: const NotesView(),
      ),
    );
  }
}
