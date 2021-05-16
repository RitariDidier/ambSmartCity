import 'package:flutter/material.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      home: MyHomePage(title: 'Flutter Demo Home Page'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: new Text("FireStore Test"),
        ),
        body: StreamBuilder(
            stream: FirebaseFirestore.instance
                .collection('notificacion')
                .snapshots(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) return Text("Cargando");
              return Column(
                children: <Widget>[
                  Text(snapshot.data.docs[0]["titulo"]),
                  Text(snapshot.data.docs[0]["descripcion"]),
                  Text("=================================="),
                  Text(snapshot.data.docs[1]["titulo"]),
                  Text(snapshot.data.docs[1]["descripcion"]),
                ],
              );
            }));
  }
}
