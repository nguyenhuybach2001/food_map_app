import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:food_map_app/change/notes_provider.dart';
import 'package:food_map_app/core/constants.dart';
import 'package:food_map_app/firebase_options.dart';
import 'package:food_map_app/pages/main_page.dart';
import 'package:provider/provider.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => NotesProvider(),
      child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Food Maps',
          theme: ThemeData(
              colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
              useMaterial3: true,
              scaffoldBackgroundColor: Colors.white,
              fontFamily: 'Poppins',
              appBarTheme: Theme.of(context).appBarTheme.copyWith(
                    backgroundColor: Colors.white,
                    titleTextStyle: const TextStyle(
                        color: primary,
                        fontSize: 32,
                        fontWeight: FontWeight.bold,
                        fontFamily: 'Fredoka'),
                  )),
          home: const MainPage()),
    );
  }
}
