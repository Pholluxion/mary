// File generated by FlutterFire CLI.
// ignore_for_file: lines_longer_than_80_chars, avoid_classes_with_only_static_members
import 'package:firebase_core/firebase_core.dart' show FirebaseOptions;
import 'package:flutter/foundation.dart'
    show defaultTargetPlatform, kIsWeb, TargetPlatform;

/// Default [FirebaseOptions] for use with your Firebase apps.
///
/// Example:
/// ```dart
/// import 'firebase_options_dev.dart';
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
    apiKey: 'AIzaSyCVHko28Ss7vRszGlqV2a7DAV0yXpw-TUw',
    appId: '1:2996708081:web:f091e52f1da53481383f50',
    messagingSenderId: '2996708081',
    projectId: 'mary-health-app-dev',
    authDomain: 'mary-health-app-dev.firebaseapp.com',
    storageBucket: 'mary-health-app-dev.appspot.com',
    measurementId: 'G-1SBG3DX3CY',
  );

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyDsfmEAp3c74gMNifAgHpPugxE5-X8jv2g',
    appId: '1:2996708081:android:697e2cfc4f400986383f50',
    messagingSenderId: '2996708081',
    projectId: 'mary-health-app-dev',
    storageBucket: 'mary-health-app-dev.appspot.com',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyAtl6sPOhCpFWkctzCoW8bqUmCEJ7kVJIk',
    appId: '1:2996708081:ios:6e1325487221f367383f50',
    messagingSenderId: '2996708081',
    projectId: 'mary-health-app-dev',
    storageBucket: 'mary-health-app-dev.appspot.com',
    iosClientId: '2996708081-84djajbqvbisuhqr91uh49vd7c4n899n.apps.googleusercontent.com',
    iosBundleId: 'com.phollux.org.mary.dev',
  );
}
