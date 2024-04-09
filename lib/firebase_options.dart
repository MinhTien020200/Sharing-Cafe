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
        return macos;
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
    apiKey: 'AIzaSyBLcZ_QKCpYSHSr8o4DYFoG2xrInQ8y4zE',
    appId: '1:11188755522:web:b54b787b94338a0ee3a1db',
    messagingSenderId: '11188755522',
    projectId: 'sharing-coffee',
    authDomain: 'sharing-coffee.firebaseapp.com',
    storageBucket: 'sharing-coffee.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyALqUwwaucN6triDlWZS2IFSAvcxKyhZ9Q',
    appId: '1:11188755522:android:11913d2ee0c35502e3a1db',
    messagingSenderId: '11188755522',
    projectId: 'sharing-coffee',
    storageBucket: 'sharing-coffee.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD2p6LbtZhFkQBGdI5pa3iKaMk8fWElzTc',
    appId: '1:11188755522:ios:7a14a4565939ac7fe3a1db',
    messagingSenderId: '11188755522',
    projectId: 'sharing-coffee',
    storageBucket: 'sharing-coffee.appspot.com',
    iosBundleId: 'com.example.sharingCafe',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD2p6LbtZhFkQBGdI5pa3iKaMk8fWElzTc',
    appId: '1:11188755522:ios:2a1c90e7ba51d383e3a1db',
    messagingSenderId: '11188755522',
    projectId: 'sharing-coffee',
    storageBucket: 'sharing-coffee.appspot.com',
    iosBundleId: 'com.example.sharingCafe.RunnerTests',
  );
}