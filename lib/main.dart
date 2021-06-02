import 'package:amb_sc/src/pages/closest_screen.dart';
import 'package:amb_sc/src/pages/pruebas.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

// void main() => runApp(MyApp());
Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Material App',
      initialRoute: "closest_screen",
      routes: {
        "closest_screen": (_) => ClosestScreen(),
        "pruebas": (_) => Pruebas()
      },
      // routes: {"closest_screen": (BuildContext context) => ClosestScreen()},
    );
  }
}
