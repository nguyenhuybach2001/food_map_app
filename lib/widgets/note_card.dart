import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:food_map_app/change/note_controller.dart';
import 'package:food_map_app/change/notes_provider.dart';
import 'package:food_map_app/core/constants.dart';
import 'package:food_map_app/core/dialogs.dart';
import 'package:food_map_app/models/note.dart';
import 'package:food_map_app/pages/detail_note_page.dart';
import 'package:food_map_app/widgets/custom_text_filed.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class NoteCard extends StatelessWidget {
  const NoteCard({
    required this.note,
    required this.isInGrid,
    super.key,
  });

  final Note note;
  final bool isInGrid;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ChangeNotifierProvider(
              create: (_) => NoteController()..note = note,
              child: DetailNotePage(
                isNewFood: false,
              ),
            ),
          ),
        );
      },
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white,
            border: Border.all(color: primary, width: 2),
            borderRadius: BorderRadius.circular(12),
            boxShadow: [
              BoxShadow(color: primary.withOpacity(0.5), offset: Offset(4, 4))
            ]),
        padding: EdgeInsets.all(12),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              note.title!,
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
              style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 16,
                  color: Colors.black),
            ),
            SizedBox(
              height: 5,
            ),
            if (isInGrid)
              Expanded(
                child: Column(
                  children: [
                   Text(
                      note.content!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(color: Colors.grey),
                    ),
                    SizedBox(
                      height: 5,
                    ),
                    if (note.imageUrl != '' && note.imageUrl!.isNotEmpty)
                      Expanded(
                        child: Image.network(
                          note.imageUrl!,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          errorBuilder: (BuildContext context, Object exception,
                              StackTrace? stackTrace) {
                            return Text('Could not load image');
                          },
                        ),
                      ),
                    SizedBox(
                      height: 5,
                    ),
                  ],
                ),
              )
            else
              CustomTextWithEllipsis(
                content: note.content!,
                maxLines: 3,
                style: TextStyle(color: Colors.grey),
              ),
            Row(
              children: [
                Text(
                  DateFormat('dd MMM, y').format(note.dateModified!.toDate()),
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey,
                      fontWeight: FontWeight.w600),
                ),
                Spacer(),
                GestureDetector(
                  onTap: () async {
                    final shouldDelete = await showConfirmationDialog(
                            context: context, title: "Bạn có chắc muốn xóa?") ??
                        false;
                    if (shouldDelete && context.mounted) {
                      final noteController =
                          Provider.of<NoteController>(context, listen: false);
                      if (note.imageUrl != null && note.imageUrl!.isNotEmpty) {
                        await noteController.deleteImage(
                            note.imageUrl!, context);
                      }
                      context
                          .read<NotesProvider>()
                          .deleteNote(note); // Optionally delete th
                    }
                    ;
                  },
                  child: FaIcon(
                    FontAwesomeIcons.trash,
                    color: Colors.grey,
                    size: 22,
                  ),
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
