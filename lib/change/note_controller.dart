import 'dart:io'; // Thêm import này để làm việc với File
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:food_map_app/models/note.dart';
import 'package:provider/provider.dart';
import 'notes_provider.dart'; // Cập nhật đường dẫn import nếu cần

class NoteController extends ChangeNotifier {
  Note? _note;

  set note(Note? value) {
    _note = value;
    _title = _note?.title ?? '';
    _content = _note?.content ?? '';
    _imageUrl = _note?.imageUrl ?? '';
    notifyListeners();
  }

  Note? get note => _note;
  bool readOnly = false;
  String _title = '';
  set title(String value) {
    _title = value;
    notifyListeners();
  }

  String get title => _title.trim();

  String _imageUrl = '';
  set imageUrl(String value) {
    _imageUrl = value;
    notifyListeners();
  }

  String get imageUrl => _imageUrl;

  String _content = '';
  set content(String value) {
    _content = value;
    notifyListeners();
  }

  String get content => _content;

  bool get isNewNote => _note == null;

  bool get canSaveNote {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent =
        content.trim().isNotEmpty ? content.trim() : null;

    bool canSave = newTitle != null || newContent != null;
    if (!isNewNote) {
      canSave &= newTitle != note!.title ||
          newContent != note!.content ||
          imageUrl != note!.imageUrl;
    }
    return canSave;
  }

  Future<void> uploadImageToFirebase(File image) async {
    try {
      String fileName =
          DateTime.now().millisecondsSinceEpoch.toString() + '.jpg';
      Reference referenceRoot = FirebaseStorage.instance.ref();
      Reference referenceDirImages = referenceRoot.child('images');
      Reference referenceImageToUpload = referenceDirImages.child(fileName);
      await referenceImageToUpload.putFile(image);
      String downloadUrl = await referenceImageToUpload.getDownloadURL();
      print('url: $downloadUrl');
      imageUrl = downloadUrl;
    } catch (e) {
      print('Failed to upload image: $e');
    }
  }

  Future<void> saveNote(BuildContext context) async {
    final String? newTitle = title.isNotEmpty ? title : null;
    final String? newContent =
        content.trim().isNotEmpty ? content.trim() : null;

    final Timestamp now = Timestamp.now();

    final Note note = Note(
      id: isNewNote ? null : _note?.id,
      title: title,
      content: content,
      dateCreated: isNewNote ? now : _note!.dateCreated,
      dateModified: now,
      imageUrl: imageUrl, // Thêm trường imageUrl
    );

    final notesProvider = context.read<NotesProvider>();
    if (isNewNote) {
      notesProvider.addNote(note);
    } else {
      notesProvider.updateNote(note);
    }
  }
}
