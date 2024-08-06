import 'package:flutter/material.dart';

class CustomTextWithEllipsis extends StatelessWidget {
  final String content;
  final int maxLines;
  final TextStyle style;

  CustomTextWithEllipsis({
    required this.content,
    required this.maxLines,
    required this.style,
  });

  @override
  Widget build(BuildContext context) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: content, style: style),
      maxLines: maxLines,
      textDirection: TextDirection.ltr,
    )..layout(maxWidth: MediaQuery.of(context).size.width);

    String displayText = content;

    if (textPainter.didExceedMaxLines) {
      // Split the content into lines
      final List<String> lines = content.split('\n');
      if (lines.length > maxLines) {
        displayText = lines.take(maxLines).join('\n') + '\n...';
      } else {
        // If the content still exceeds the lines limit after split
        final TextSpan span = TextSpan(text: content, style: style);
        final TextPainter painter = TextPainter(
          text: span,
          maxLines: maxLines,
          textDirection: TextDirection.ltr,
        )..layout(maxWidth: MediaQuery.of(context).size.width);

        int endIndex = painter
            .getPositionForOffset(
              Offset(painter.width, painter.height),
            )
            .offset;

        displayText = content.substring(0, endIndex) + '\n...';
      }
    }

    return Text(
      displayText,
      style: style,
    );
  }
}
