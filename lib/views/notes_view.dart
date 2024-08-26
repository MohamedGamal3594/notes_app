import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:notes_app/constants.dart';
import 'package:notes_app/cubits/notes_cubit.dart';
import 'package:notes_app/models/note_model.dart';
import 'package:notes_app/views/edit_note_view.dart';
import 'package:notes_app/widgets/custom_text_field.dart';
import 'package:uuid/uuid.dart';

class NotesView extends StatelessWidget {
  const NotesView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Notes',
          style: TextStyle(fontSize: 32),
        ),
        centerTitle: false,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          showModalBottomSheet(
            shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
              ),
            ),
            context: context,
            builder: (context) {
              return const _AddNoteBottomSheet();
            },
          );
        },
        foregroundColor: Colors.black,
        backgroundColor: Colors.white,
        shape: const CircleBorder(),
        child: const Icon(Icons.add),
      ),
      body: const SafeArea(
        bottom: false,
        child: _NotesViewBody(),
      ),
    );
  }
}

class _AddNoteBottomSheet extends StatefulWidget {
  const _AddNoteBottomSheet();

  @override
  State<_AddNoteBottomSheet> createState() => _AddNoteBottomSheetState();
}

class _AddNoteBottomSheetState extends State<_AddNoteBottomSheet> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _contentController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        bottom: MediaQuery.of(context).viewInsets.bottom,
      ),
      child: SingleChildScrollView(
        child: Form(
          key: _formKey,
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Column(
              children: [
                const SizedBox(height: 32),
                CustomTextField(
                  label: 'Title',
                  controller: _titleController,
                ),
                const SizedBox(height: 16),
                CustomTextField(
                  label: 'Content',
                  maxLines: 5,
                  controller: _contentController,
                ),
                const SizedBox(height: 64),
                _AddButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      context
                          .read<NotesCubit>()
                          .addNote(
                            const Uuid().v1(),
                            _titleController.text,
                            _contentController.text,
                            DateFormat('MMMM d, y').format(DateTime.now()),
                          )
                          .then((_) => Navigator.pop(context))
                          .onError((e, _) {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(content: Text(e.toString())),
                        );
                      });
                    }
                  },
                ),
                const SizedBox(height: 32),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _AddButton extends StatelessWidget {
  const _AddButton({required this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      height: 55,
      child: FilledButton(
        onPressed: onPressed,
        style: ButtonStyle(
          backgroundColor: WidgetStateProperty.all(kPrimaryColor),
          shape: WidgetStateProperty.all(
            const RoundedRectangleBorder(
              borderRadius: BorderRadius.all(Radius.circular(8)),
            ),
          ),
        ),
        child: const Text(
          'Add',
          style: TextStyle(
            color: Colors.black,
            fontWeight: FontWeight.bold,
            fontSize: 16,
          ),
        ),
      ),
    );
  }
}

class _NotesViewBody extends StatelessWidget {
  const _NotesViewBody();
  final List<Color> colors = const [
    Colors.orangeAccent,
    Colors.greenAccent,
    Colors.blueAccent,
    Colors.redAccent,
    Colors.purpleAccent,
    Colors.yellowAccent,
  ];
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<NotesCubit, NotesState>(
      builder: (context, state) {
        if (state is NotesLoaded) {
          if (state.notes.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.notes_rounded, size: 32),
                  SizedBox(height: 8),
                  Text('No notes'),
                ],
              ),
            );
          }
          return ListView.builder(
            itemCount: state.notes.length,
            padding: const EdgeInsets.symmetric(vertical: 8),
            itemBuilder: (context, index) {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                child: _NoteItem(
                  note: state.notes[index],
                  color: colors[index % colors.length],
                ),
              );
            },
          );
        } else {
          return const SizedBox();
        }
      },
    );
  }
}

class _NoteItem extends StatelessWidget {
  const _NoteItem({required this.note, required this.color});
  final NoteModel note;
  final Color color;
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => EditNoteView(note: note),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
          color: color,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: [
            ListTile(
              title: Text(
                note.title,
                style: const TextStyle(
                  fontSize: 32,
                  fontWeight: FontWeight.w500,
                  color: Colors.black,
                ),
              ),
              subtitle: Text(
                note.subTitle,
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.w400,
                  color: Colors.black45,
                ),
              ),
              trailing: IconButton(
                onPressed: () {
                  context.read<NotesCubit>().deleteNote(note).onError((e, _) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(e.toString()),
                      ),
                    );
                  });
                },
                icon: const Icon(
                  Icons.delete,
                  color: Colors.black,
                  size: 32,
                ),
              ),
              contentPadding:
                  const EdgeInsets.only(left: 24, top: 16, right: 8),
            ),
            Padding(
              padding: const EdgeInsets.only(right: 24, bottom: 24),
              child: Text(
                note.date,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.black45,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
