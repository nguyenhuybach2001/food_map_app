import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_map_app/change/note_controller.dart';
import 'package:food_map_app/change/notes_provider.dart';
import 'package:food_map_app/core/constants.dart';
import 'package:food_map_app/models/note.dart';
import 'package:food_map_app/widgets/no_note.dart';
// import 'package:food_map_app/pages/detail_note_page.dart';
import 'package:food_map_app/widgets/note_card.dart';
import 'package:food_map_app/widgets/note_fab.dart';
import 'package:food_map_app/widgets/notes_grid.dart';
import 'package:food_map_app/widgets/notes_list.dart';
import 'package:food_map_app/widgets/search_field.dart';
import 'package:food_map_app/widgets/view_option.dart';
import 'package:provider/provider.dart';

import 'detail_note_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({super.key});

  @override
  State<MainPage> createState() => _MainPageState();
}

class _MainPageState extends State<MainPage> {
  // CollectionReference tasks = FirebaseFirestore.instance.collection('tasks');
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text("Food Map"),
          // actions: [Note_Btn()],
        ),
        floatingActionButton: NoteFab(
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => ChangeNotifierProvider(
                  create: (context) => NoteController(),
                  child: const DetailNotePage(
                    isNewFood: true,
                  ),
                ),
              ),
            );
          },
        ),
        body: Consumer<NotesProvider>(builder: (context, notesProvider, child) {
          final List<Note> notes = notesProvider.notes;
          return notes.isEmpty && notesProvider.searchTerm.isEmpty
              ? NoNotes()
              : Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    children: [
                      const SearchField(),
                      if (notes.isNotEmpty) ...[
                        const ViewOptions(),
                        Expanded(
                          child: notesProvider.isGrid
                              ? NotesGrid(notes: notes)
                              : NoteList(notes: notes),
                        ),
                      ] else
                        const Expanded(
                          child: Center(
                            child: Text(
                              'No notes found for your search query!',
                              textAlign: TextAlign.center,
                            ),
                          ),
                        ),
                    ],
                  ),
                );
        }));
  }
}
