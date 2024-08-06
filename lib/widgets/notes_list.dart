import 'package:flutter/material.dart';
import 'package:food_map_app/models/note.dart';
import 'package:food_map_app/widgets/note_card.dart';

class NoteList extends StatefulWidget {
  const NoteList({required this.notes, super.key});

  final List<Note> notes;

  @override
  State<NoteList> createState() => _NoteListState();
}

class _NoteListState extends State<NoteList> {
  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: widget.notes.length,
      clipBehavior: Clip.none,
      itemBuilder: (context, index) {
        return NoteCard(
          note: widget.notes[index],
          isInGrid: false,
        );
      },
      separatorBuilder: (context, index) => SizedBox(
        height: 8,
      ),
    );
  }
}
