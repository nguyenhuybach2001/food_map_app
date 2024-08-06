import 'package:flutter/material.dart';
import 'package:food_map_app/widgets/dialog.dart';
import 'package:food_map_app/widgets/note_button.dart';

class ConfirmationDialog extends StatelessWidget {
  const ConfirmationDialog({
    super.key,
    required this.title,
  });
  final String title;

  @override
  Widget build(BuildContext context) {
    return DialogCard(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            title,
            style: const TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.bold,
            ),
            textAlign: TextAlign.start,
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              NoteButtonAdd(
                label: 'No',
                onPressed: () => Navigator.pop(context, false),
              ),
              SizedBox(
                width: 8,
              ),
              NoteButtonAdd(
                label: 'Yes',
                onPressed: () => Navigator.pop(context, true),
              )
            ],
          ),
        ],
      ),
    );
  }
}
