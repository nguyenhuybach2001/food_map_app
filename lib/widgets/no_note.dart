import 'package:flutter/material.dart';

class NoNotes extends StatelessWidget {
  const NoNotes({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment:
              MainAxisAlignment.center, // Căn giữa theo chiều dọc
          crossAxisAlignment:
              CrossAxisAlignment.center, // Căn giữa theo chiều ngang
          children: [
            Image.asset(
              'assets/images/person.png',
              width: MediaQuery.sizeOf(context).width * 0.75,
            ),
            SizedBox(
              height: 32,
            ),
            Text(
              'Hiện chưa có list món ăn nào, hãy thêm món ăn mới ngay.',
              style: TextStyle(
                  fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            )
          ],
        ),
      );
  }
}
