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
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions web = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    authDomain: '',
    databaseURL: '',
    storageBucket: '',
    measurementId: '',
  );
  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyB6dCFXmiSyh2zWR0I0Z-lq4rC3FiVXtZo',
    appId: '1:855488605666:android:70f0e079f5f9deaf569dbb',
    messagingSenderId: '',
    projectId: 'ekank-project',
    authDomain:
        '855488605666-aoojgu06un632emdr7nl4jpj7ti1m19l.apps.googleusercontent.com',
    databaseURL: '',
    storageBucket: 'ekank-project.appspot.com',
    measurementId: '',
  );
  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    authDomain: '',
    databaseURL: '',
    storageBucket: '',
    measurementId: '',
  );
  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: '',
    appId: '',
    messagingSenderId: '',
    projectId: '',
    authDomain: '',
    databaseURL: '',
    storageBucket: '',
    measurementId: '',
  );
}
