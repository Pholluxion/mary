import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:mary/app/app.dart';
import 'package:mary/bootstrap.dart';

import 'config/firebase/firebase_options_dev.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await bootstrap(() => const App());
}
