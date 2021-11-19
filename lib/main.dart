// @dart=2.9

import 'package:autentic_apps/get_started/get_started.dart';
import 'package:autentic_apps/routes.dart';
import 'package:autentic_apps/theme/color.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(
      SystemUiOverlayStyle(
        statusBarColor: Colors.white,
      ),
    );
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Learning_authentic',
      // We use routeName so that we dont need to remember the name
      initialRoute: Onboarding.routeName,
      routes: routes,
    );
  }
}
