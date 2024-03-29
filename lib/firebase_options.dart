// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
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
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for macos - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
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
    apiKey: 'AIzaSyDwVuLD5wz1uP9SDhctPDrYwIdQiVz2Tqg',
    appId: '1:308544789158:web:b00cc01f168e87c365b267',
    messagingSenderId: '308544789158',
    projectId: 'ditonton-7ef8f',
    authDomain: 'ditonton-7ef8f.firebaseapp.com',
    storageBucket: 'ditonton-7ef8f.appspot.com',
    measurementId: 'G-JFZW1GS7MP',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDpDTKCANKzF7iKjE-OgrM9Fs6h9R04Bak',
    appId: '1:308544789158:android:76b5ff5abd38359365b267',
    messagingSenderId: '308544789158',
    projectId: 'ditonton-7ef8f',
    storageBucket: 'ditonton-7ef8f.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyCU1553erv9-5l_nTEPbMXwTQqX-jMFOaw',
    appId: '1:308544789158:ios:6d65a524b9d798d165b267',
    messagingSenderId: '308544789158',
    projectId: 'ditonton-7ef8f',
    storageBucket: 'ditonton-7ef8f.appspot.com',
    iosClientId: '308544789158-o00iemdi3hakp77l6nf12rpgv8thb10d.apps.googleusercontent.com',
    iosBundleId: 'com.dicoding.ditonton',
  );
}
