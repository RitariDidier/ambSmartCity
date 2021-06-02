import 'package:amb_sc/src/providers/eventos_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClosestScreen extends StatefulWidget {
  @override
  _ClosestScreenState createState() => _ClosestScreenState();
}

class _ClosestScreenState extends State<ClosestScreen> {
  EventosProvider eventosProvider = new EventosProvider();

  List data = [""];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: eventosProvider.getClosest(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            snapshot.data.listen((List<DocumentSnapshot> documentList) {
              this.data = documentList.map((e) => e.data()).toList();
            });

            return Scaffold(
              appBar: AppBar(
                title: Text('Lugares Cercanos'),
              ),
              body: Column(
                children:
                    //  _listaItems()
                    [
                  Text(data.toString()),
                  SizedBox(
                    height: 50,
                  ),
                  Text(data[0].toString()),
                  SizedBox(
                    height: 100,
                  ),
                  SizedBox(
                    height: 100,
                  ),
                  FloatingActionButton(onPressed: () {
                    setState(() {});
                  })
                ],
              ),
            );
          } else {
            return Text("Sin data");
          }
        },
      ),
    );
  }

  List<Widget> _listaItems() {
    return [
      ListTile(
        title: Text(this.data[0].toString()),
      ),
      Divider(),
      ListTile(
        title: Text(this.data[1].toString()),
      ),
      Divider(),
      ListTile(
        title: Text(this.data[2].toString()),
      ),
      Divider()
    ];
  }
}

//  setState(() {});