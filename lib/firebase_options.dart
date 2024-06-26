// File generated by FlutterFire CLI.
// ignore_for_file: type=lint
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

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
    apiKey: 'OMITTED',
    appId: 'OMITTED',
    messagingSenderId: 'OMITTED',
    projectId: 'OMITTED',
    authDomain: 'OMITTED',
    storageBucket: 'OMITTED',
    measurementId: 'OMITTED',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'OMITTED',
    appId: 'OMITTED',
    messagingSenderId: 'OMITTED',
    projectId: 'OMITTED',
    storageBucket: 'OMITTED',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'OMITTED',
    appId: 'OMITTED',
    messagingSenderId: 'OMITTED',
    projectId: 'OMITTED',
    storageBucket: 'OMITTED',
    androidClientId: 'OMITTED',
    iosClientId: 'OMITTED',
    iosBundleId: 'OMITTED',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'OMITTED',
    appId: 'OMITTED',
    messagingSenderId: 'OMITTED',
    projectId: 'OMITTED',
    storageBucket: 'OMITTED',
    androidClientId: 'OMITTED',
    iosClientId: 'OMITTED',
    iosBundleId: 'OMITTED',
  );

  static const FirebaseOptions windows = FirebaseOptions(
    apiKey: 'OMITTED',
    appId: 'OMITTED',
    messagingSenderId: 'OMITTED',
    projectId: 'OMITTED',
    authDomain: 'OMITTED',
    storageBucket: 'OMITTED',
    measurementId: 'OMITTED',
  );
}
