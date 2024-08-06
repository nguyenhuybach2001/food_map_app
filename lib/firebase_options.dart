// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options.dart';
/// // ...
/// await Firebase.initializeApp(
///   options: DefaultFirebaseOptions.currentPlatform,
/// );
/// ```
class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    if (kIsWeb) {
      return web;
    }
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;
      case TargetPlatform.macOS:
        return macos;
      case TargetPlatform.windows:
        return windows;
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: 'AIzaSyAW01YANZq-c8EjL4mM-4vLTHStQthlJys',
    appId: '1:930888968515:web:1451424f41c598f5a727f6',
    messagingSenderId: '930888968515',
    projectId: 'foodmap-5066d',
    authDomain: 'foodmap-5066d.firebaseapp.com',
    storageBucket: 'foodmap-5066d.appspot.com',
    measurementId: 'G-P2GX4PYNTE',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD9WmvC9NOKa_co9XOACkU62iC9XCqvJ2g',
    appId: '1:930888968515:android:365839b28903f6e2a727f6',
    messagingSenderId: '930888968515',
    projectId: 'foodmap-5066d',
    storageBucket: 'foodmap-5066d.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBXK7aiM0lebWy38Kj4zaYj-vvNqti8uxA',
    appId: '1:930888968515:ios:0fd847341b71c1f0a727f6',
    messagingSenderId: '930888968515',
    projectId: 'foodmap-5066d',
    storageBucket: 'foodmap-5066d.appspot.com',
    iosBundleId: 'com.example.foodMapApp',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBXK7aiM0lebWy38Kj4zaYj-vvNqti8uxA',
    appId: '1:930888968515:ios:0fd847341b71c1f0a727f6',
    messagingSenderId: '930888968515',
    projectId: 'foodmap-5066d',
    storageBucket: 'foodmap-5066d.appspot.com',
    iosBundleId: 'com.example.foodMapApp',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyAW01YANZq-c8EjL4mM-4vLTHStQthlJys',
    appId: '1:930888968515:web:b43eb741a8ad3e83a727f6',
    messagingSenderId: '930888968515',
    projectId: 'foodmap-5066d',
    authDomain: 'foodmap-5066d.firebaseapp.com',
    storageBucket: 'foodmap-5066d.appspot.com',
    measurementId: 'G-E3J5MZML79',
  );
}
