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
    apiKey: 'AIzaSyBftCpNKiCEx7qXNpcoYMNF4K-STlPqjF0',
    appId: '1:463434272959:web:8502b43017152b9c80f60a',
    messagingSenderId: '463434272959',
    projectId: 'coiso-7c7f3',
    authDomain: 'coiso-7c7f3.firebaseapp.com',
    storageBucket: 'coiso-7c7f3.firebasestorage.app',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCCM1JbLaUbyLg1gsTuq2zh07P1CX6661A',
    appId: '1:463434272959:android:181bd0c5bb3a2f4380f60a',
    messagingSenderId: '463434272959',
    projectId: 'coiso-7c7f3',
    storageBucket: 'coiso-7c7f3.firebasestorage.app',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAAjLFT3vL8GVRPXAs1rx8BOUiwDtje_zI',
    appId: '1:463434272959:ios:1f5ec274014f50cb80f60a',
    messagingSenderId: '463434272959',
    projectId: 'coiso-7c7f3',
    storageBucket: 'coiso-7c7f3.firebasestorage.app',
    iosBundleId: 'com.example.notebook',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyAAjLFT3vL8GVRPXAs1rx8BOUiwDtje_zI',
    appId: '1:463434272959:ios:1f5ec274014f50cb80f60a',
    messagingSenderId: '463434272959',
    projectId: 'coiso-7c7f3',
    storageBucket: 'coiso-7c7f3.firebasestorage.app',
    iosBundleId: 'com.example.notebook',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'AIzaSyBftCpNKiCEx7qXNpcoYMNF4K-STlPqjF0',
    appId: '1:463434272959:web:ba8c2884a722505a80f60a',
    messagingSenderId: '463434272959',
    projectId: 'coiso-7c7f3',
    authDomain: 'coiso-7c7f3.firebaseapp.com',
    storageBucket: 'coiso-7c7f3.firebasestorage.app',
  );

}