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
    apiKey: 'AIzaSyC-8Q5cyRpkl7guAJ2Kq6iZ-v_p0Um5AyU',
    appId: '1:688010729153:web:0d25be949b5afe71fd2640',
    messagingSenderId: '688010729153',
    projectId: 'kiddielink-eaf5a',
    authDomain: 'kiddielink-eaf5a.firebaseapp.com',
    storageBucket: 'kiddielink-eaf5a.appspot.com',
    measurementId: 'G-E8ZVLKKPRL',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAu0896V8rSPnXA5OxNk7kxdUzSerIh1as',
    appId: '1:688010729153:android:26b0f057174afefefd2640',
    messagingSenderId: '688010729153',
    projectId: 'kiddielink-eaf5a',
    storageBucket: 'kiddielink-eaf5a.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyBkyEMSfZnmUf8rSiB7pBYP8TT75yVvcnI',
    appId: '1:688010729153:ios:63fc01e6cd148c1afd2640',
    messagingSenderId: '688010729153',
    projectId: 'kiddielink-eaf5a',
    storageBucket: 'kiddielink-eaf5a.appspot.com',
    iosBundleId: 'com.example.kiddielinkAttendance',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyBkyEMSfZnmUf8rSiB7pBYP8TT75yVvcnI',
    appId: '1:688010729153:ios:63fc01e6cd148c1afd2640',
    messagingSenderId: '688010729153',
    projectId: 'kiddielink-eaf5a',
    storageBucket: 'kiddielink-eaf5a.appspot.com',
    iosBundleId: 'com.example.kiddielinkAttendance',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyC-8Q5cyRpkl7guAJ2Kq6iZ-v_p0Um5AyU',
    appId: '1:688010729153:web:59cd5a6c5c668ff2fd2640',
    messagingSenderId: '688010729153',
    projectId: 'kiddielink-eaf5a',
    authDomain: 'kiddielink-eaf5a.firebaseapp.com',
    storageBucket: 'kiddielink-eaf5a.appspot.com',
    measurementId: 'G-49DSEQB16Q',
  );
}
