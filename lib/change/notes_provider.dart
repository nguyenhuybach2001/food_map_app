import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';

import '../enums/order_option.dart';
import '../models/note.dart';

class NotesProvider extends ChangeNotifier {
  NotesProvider() {
    getNotes();
  }

  CollectionReference<Map<String, dynamic>> notesCollection =
      FirebaseFirestore.instance.collection('notes');

  void getNotes() {
    notesCollection.snapshots().listen((snapshot) {
      _notes.clear();
      snapshot.docs.forEach((doc) {
        final note = Note.fromJson(doc.data());
        note.id = doc.id;
        _notes.add(note);
      });
      print(
        _notes,
      );
      notifyListeners();
    });
  }

  final List<Note> _notes = [];

  List<Note> get notes =>
      [..._searchTerm.isEmpty ? _notes : _notes.where(_test)]..sort(_compare);

  bool _test(Note note) {
    final term = _searchTerm.toLowerCase().trim();
    final title = note.title?.toLowerCase() ?? '';
    final content = note.content?.toLowerCase() ?? '';
    return title.contains(term) || content.contains(term);
  }

  int _compare(Note note1, note2) {
    return _orderBy == OrderOption.dateModified
        ? _isDescending
            ? note2.dateModified.compareTo(note1.dateModified)
            : note1.dateModified?.compareTo(note2.dateModified)
        : _isDescending
            ? note2.dateCreated.compareTo(note1.dateCreated)
            : note1.dateCreated?.compareTo(note2.dateCreated);
  }

  void addNote(Note note) {
    final newDoc = notesCollection.doc();
    note.id = newDoc.id;
    newDoc.set(note.toJson());
    print(note);
    notifyListeners();
  }

  void updateNote(Note note) {
    print(notesCollection.doc(note.id));
    notesCollection.doc(note.id).update(note.toJson());
    notifyListeners();
  }

  void deleteNote(Note note) async {
    notesCollection.doc(note.id).delete();
    Reference storageReference =
        FirebaseStorage.instance.refFromURL(note.imageUrl!);
    await storageReference.delete();
    notifyListeners();
  }

  OrderOption _orderBy = OrderOption.dateModified;
  set orderBy(OrderOption value) {
    _orderBy = value;
    notifyListeners();
  }

  OrderOption get orderBy => _orderBy;

  bool _isDescending = true;
  set isDescending(bool value) {
    _isDescending = value;
    notifyListeners();
  }

  bool get isDescending => _isDescending;

  bool _isGrid = true;
  set isGrid(bool value) {
    _isGrid = value;
    notifyListeners();
  }

  bool get isGrid => _isGrid;

  String _searchTerm = '';
  set searchTerm(String value) {
    _searchTerm = value;
    notifyListeners();
  }

  String get searchTerm => _searchTerm;
}
