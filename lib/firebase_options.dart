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
    apiKey: 'AIzaSyDP0gj9opC1g4J-4r-smcBwTQO9Cwsyb_s',
    appId: '1:913392175991:web:1fd5d222fd0c1eb89eaf72',
    messagingSenderId: '913392175991',
    projectId: 'peer-tutoring-app-f22d5',
    authDomain: 'peer-tutoring-app-f22d5.firebaseapp.com',
    storageBucket: 'peer-tutoring-app-f22d5.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyAhwfU0wO66uFwta2VKsuNm-YbapPd5yJQ',
    appId: '1:913392175991:android:5e84b01590d1af369eaf72',
    messagingSenderId: '913392175991',
    projectId: 'peer-tutoring-app-f22d5',
    storageBucket: 'peer-tutoring-app-f22d5.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD40hco2LAxbhHKguXqF8OfAVpD0l2TbFs',
    appId: '1:913392175991:ios:a0e08ce18654d0c29eaf72',
    messagingSenderId: '913392175991',
    projectId: 'peer-tutoring-app-f22d5',
    storageBucket: 'peer-tutoring-app-f22d5.firebasestorage.app',
    iosBundleId: 'com.example.maeAssignment',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD40hco2LAxbhHKguXqF8OfAVpD0l2TbFs',
    appId: '1:913392175991:ios:a0e08ce18654d0c29eaf72',
    messagingSenderId: '913392175991',
    projectId: 'peer-tutoring-app-f22d5',
    storageBucket: 'peer-tutoring-app-f22d5.firebasestorage.app',
    iosBundleId: 'com.example.maeAssignment',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyDP0gj9opC1g4J-4r-smcBwTQO9Cwsyb_s',
    appId: '1:913392175991:web:edea91f977df2d809eaf72',
    messagingSenderId: '913392175991',
    projectId: 'peer-tutoring-app-f22d5',
    authDomain: 'peer-tutoring-app-f22d5.firebaseapp.com',
    storageBucket: 'peer-tutoring-app-f22d5.firebasestorage.app',
  );
}
