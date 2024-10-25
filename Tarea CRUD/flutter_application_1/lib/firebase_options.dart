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
    apiKey: 'AIzaSyDgLnMrwsW5PI7A77Y1A7UdGokPn__fUw4',
    appId: '1:99849603834:web:714eb48630fa80e8a59743',
    messagingSenderId: '99849603834',
    projectId: 'flutter-test-d0c48',
    authDomain: 'flutter-test-d0c48.firebaseapp.com',
    storageBucket: 'flutter-test-d0c48.appspot.com',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDgLnMrwsW5PI7A77Y1A7UdGokPn__fUw4',
    appId: '1:99849603834:web:f22e91f2b7be8bcba59743',
    messagingSenderId: '99849603834',
    projectId: 'flutter-test-d0c48',
    authDomain: 'flutter-test-d0c48.firebaseapp.com',
    storageBucket: 'flutter-test-d0c48.appspot.com',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyCXS28omt40PfPsoDskvhf1RjW7Ik3p2lE',
    appId: '1:99849603834:ios:880796470abd16c2a59743',
    messagingSenderId: '99849603834',
    projectId: 'flutter-test-d0c48',
    storageBucket: 'flutter-test-d0c48.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCXS28omt40PfPsoDskvhf1RjW7Ik3p2lE',
    appId: '1:99849603834:ios:880796470abd16c2a59743',
    messagingSenderId: '99849603834',
    projectId: 'flutter-test-d0c48',
    storageBucket: 'flutter-test-d0c48.appspot.com',
    iosBundleId: 'com.example.flutterApplication1',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyA4xbe3a6lHsg6ZQYfUObIL9-8ERN6dn_0',
    appId: '1:99849603834:android:4c8fe8de7804adf7a59743',
    messagingSenderId: '99849603834',
    projectId: 'flutter-test-d0c48',
    storageBucket: 'flutter-test-d0c48.appspot.com',
  );

}