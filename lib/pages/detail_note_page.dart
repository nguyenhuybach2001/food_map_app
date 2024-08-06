import 'dart:io';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_map_app/change/note_controller.dart';
import 'package:food_map_app/change/notes_provider.dart';
import 'package:food_map_app/core/dialogs.dart';
import 'package:food_map_app/widgets/dialog.dart';
import 'package:food_map_app/widgets/note_btn.dart';
import 'package:food_map_app/widgets/note_button.dart';
import 'package:food_map_app/widgets/note_metadata.dart';
import 'package:image_picker/image_picker.dart';
import 'package:provider/provider.dart';
import 'package:firebase_storage/firebase_storage.dart';

class DetailNotePage extends StatefulWidget {
  const DetailNotePage({
    required this.isNewFood,
    super.key,
  });

  final bool isNewFood;
  @override
  State<DetailNotePage> createState() => _DetailNotePageState();
}

class _DetailNotePageState extends State<DetailNotePage> {
  late final NoteController newNoteController;
  late final TextEditingController titleController;
  late final TextEditingController contentController;
  late final FocusNode focusNode;
  final ImagePicker _picker = ImagePicker();
  final FirebaseStorage _storage = FirebaseStorage.instance;

  @override
  void initState() {
    super.initState();
    newNoteController = context.read<NoteController>();
    focusNode = FocusNode();
    titleController = TextEditingController(text: newNoteController.title);
    contentController = TextEditingController(text: newNoteController.content);
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      if (widget.isNewFood) {
        focusNode.requestFocus();
        newNoteController.readOnly = false;
      } else {
        newNoteController.readOnly = true;
      }
    });
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    focusNode.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final pickedFile = await showModalBottomSheet<ImageSource>(
      context: context,
      builder: (context) => Wrap(
        children: [
          ListTile(
            leading: Icon(Icons.camera),
            title: Text('Chụp ảnh từ camera'),
            onTap: () => Navigator.pop(context, ImageSource.camera),
          ),
          ListTile(
            leading: Icon(Icons.photo_library),
            title: Text('Chọn ảnh từ thư viện'),
            onTap: () => Navigator.pop(context, ImageSource.gallery),
          ),
        ],
      ),
    );

    if (pickedFile != null) {
      final pickedImage = await _picker.pickImage(source: pickedFile);
      if (pickedImage != null) {
        newNoteController.uploadImageToFirebase(File(pickedImage.path));
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        if (!newNoteController.canSaveNote) {
          Navigator.pop(context);
          return;
        }

        final bool? shouldSave = await showConfirmationDialog(
            context: context, title: "Bạn muốn lưu món ăn?");
        if (shouldSave == null) return;
        if (!context.mounted) return;
        if (shouldSave) {
          newNoteController.saveNote(context);
        }
        Navigator.pop(context);
      },
      child: Scaffold(
        appBar: AppBar(
          leading: Padding(
            padding: const EdgeInsets.all(8.0),
            child: Note_Btn(
              icon: FontAwesomeIcons.chevronLeft,
              onPressed: () {
                Navigator.maybePop(context);
              },
            ),
          ),
          title: Text(widget.isNewFood ? "New food" : "Edit"),
          actions: [
            Selector<NoteController, bool>(
              selector: (_, newNoteController) => newNoteController.canSaveNote,
              builder: (_, canSaveNote, __) => Note_Btn(
                icon: FontAwesomeIcons.check,
                onPressed: canSaveNote
                    ? () {
                        newNoteController.saveNote(context);
                        Navigator.pop(context);
                      }
                    : null,
              ),
            ),
          ],
        ),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            children: [
              TextField(
                controller: titleController,
                canRequestFocus: true,
                onChanged: (value) {
                  newNoteController.title = value;
                },
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                decoration: InputDecoration(
                    hintText: "Title here",
                    border: InputBorder.none,
                    hintStyle: TextStyle(color: Colors.grey)),
              ),
              NoteMetadata(note: newNoteController.note),
              Divider(),
              Expanded(
                child: Column(
                  children: [
                    TextField(
                      onChanged: (value) {
                        newNoteController.content = value;
                      },
                      controller: contentController,
                      decoration: InputDecoration(
                        hintText: "Description here",
                      ),
                      maxLines: null,
                    ),
                    SizedBox(height: 8),
                    newNoteController.imageUrl == ''
                        ? TextButton.icon(
                            icon: Icon(Icons.image),
                            label: Text('Add Image'),
                            onPressed: _pickImage,
                          )
                        : Column(
                            children: [
                              Image.network(
                                newNoteController.imageUrl,
                                height: 200,
                                width: double.infinity,
                                fit: BoxFit.cover,
                              ),
                              SizedBox(height: 8),
                              // Remove the upload button as the image is uploaded automatically
                            ],
                          )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
