import 'package:flutter/material.dart';
import 'package:food_map_app/models/note.dart';
import 'package:food_map_app/widgets/note_card.dart';

class NotesGrid extends StatelessWidget {
  const NotesGrid({required this.notes, super.key});

  final List<Note> notes;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: notes.length,
        clipBehavior: Clip.none,
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: 2, mainAxisSpacing: 8, crossAxisSpacing: 8),
        itemBuilder: (context, int index) {
          return NoteCard(
            note: notes[index],
            isInGrid: true,
          );
        });
  }
}
