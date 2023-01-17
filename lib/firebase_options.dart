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
      throw UnsupportedError(
        'DefaultFirebaseOptions have not been configured for web - '
        'you can reconfigure this by running the FlutterFire CLI again.',
      );
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

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAisevEyIwa55HloGsIxMR8GSEedaog_64',
    appId: '1:301380498917:android:c582464ffea5b6e5a32b0c',
    messagingSenderId: '301380498917',
    projectId: 'flutter-firebase-app-d7ddb',
    storageBucket: 'flutter-firebase-app-d7ddb.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyArCxMLzOmRZItWtIBooIFPmxpQUKsPwwg',
    appId: '1:301380498917:ios:99405a13db023c4fa32b0c',
    messagingSenderId: '301380498917',
    projectId: 'flutter-firebase-app-d7ddb',
    storageBucket: 'flutter-firebase-app-d7ddb.appspot.com',
    iosClientId: '301380498917-qasqtq16qpgne0s7rn4ri9kccljl1464.apps.googleusercontent.com',
    iosBundleId: 'com.example.flutterFirebaseApp',
  );
}
