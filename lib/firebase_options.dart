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
    apiKey: 'AIzaSyD-D_2--6yr-MlXZvdozSdT86STswnti3o',
    appId: '1:433969335152:web:c788a9af105bbd403a1db5',
    messagingSenderId: '433969335152',
    projectId: 'mychat-162b9',
    authDomain: 'mychat-162b9.firebaseapp.com',
    storageBucket: 'mychat-162b9.appspot.com',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyBYOR9KIr7OBhBYGoBrdZBTfRaMM4rxj7w',
    appId: '1:433969335152:android:fdb374637ad29eb73a1db5',
    messagingSenderId: '433969335152',
    projectId: 'mychat-162b9',
    storageBucket: 'mychat-162b9.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyD2WLf9gGVQzwOotFe2iALD-gXiHxIlTkM',
    appId: '1:433969335152:ios:e15998569f1973093a1db5',
    messagingSenderId: '433969335152',
    projectId: 'mychat-162b9',
    storageBucket: 'mychat-162b9.appspot.com',
    iosClientId: '433969335152-1oteo1bjemgf367q7bofjem1a1u0uvah.apps.googleusercontent.com',
    iosBundleId: 'com.example.mychat',
  );

  static const FirebaseOptions macos = FirebaseOptions(
    apiKey: 'AIzaSyD2WLf9gGVQzwOotFe2iALD-gXiHxIlTkM',
    appId: '1:433969335152:ios:e15998569f1973093a1db5',
    messagingSenderId: '433969335152',
    projectId: 'mychat-162b9',
    storageBucket: 'mychat-162b9.appspot.com',
    iosClientId: '433969335152-1oteo1bjemgf367q7bofjem1a1u0uvah.apps.googleusercontent.com',
    iosBundleId: 'com.example.mychat',
  );
}