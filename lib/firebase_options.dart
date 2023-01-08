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
    apiKey: 'AIzaSyAbFBE83lftRyi-GNjXUPJZa8VLIaIDVZ8',
    appId: '1:274123084294:web:f810df0bd0d735388be987',
    messagingSenderId: '274123084294',
    projectId: 'onyx-2cac8',
    authDomain: 'onyx-2cac8.firebaseapp.com',
    storageBucket: 'onyx-2cac8.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyCBnK5WvuQnet7K_aYhoBKt7iVFS3nCutM',
    appId: '1:274123084294:android:1cbb657717cc48998be987',
    messagingSenderId: '274123084294',
    projectId: 'onyx-2cac8',
    storageBucket: 'onyx-2cac8.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyA_3LceBKbkwyzPkdcYJeKehRiSJEh2g74',
    appId: '1:274123084294:ios:0505a67c6a7437e48be987',
    messagingSenderId: '274123084294',
    projectId: 'onyx-2cac8',
    storageBucket: 'onyx-2cac8.appspot.com',
    iosClientId: '274123084294-4bq3lgl0qilu7ps4k9j07vd6s568kdie.apps.googleusercontent.com',
    iosBundleId: 'com.onyx.app',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyA_3LceBKbkwyzPkdcYJeKehRiSJEh2g74',
    appId: '1:274123084294:ios:0505a67c6a7437e48be987',
    messagingSenderId: '274123084294',
    projectId: 'onyx-2cac8',
    storageBucket: 'onyx-2cac8.appspot.com',
    iosClientId: '274123084294-4bq3lgl0qilu7ps4k9j07vd6s568kdie.apps.googleusercontent.com',
    iosBundleId: 'com.onyx.app',
  );
}