import 'package:amb_sc/src/models/evento_model.dart';
import 'package:amb_sc/src/providers/eventos_provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class ClosestScreen extends StatefulWidget {
  @override
  _ClosestScreenState createState() => _ClosestScreenState();
}

class _ClosestScreenState extends State<ClosestScreen> {
  EventosProvider eventosProvider = new EventosProvider();

  List<EventoModel> data = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: eventosProvider.getClosest(),
        builder: (BuildContext context, AsyncSnapshot snapshot) {
          if (snapshot.hasData) {
            snapshot.data.listen((List<DocumentSnapshot> documentList) {
              this.data = documentList
                  .map((e) => EventoModel.fromJson(e.data()))
                  .toList();
            });

            return Scaffold(
              appBar: AppBar(
                title: Text('Lugares Cercanos'),
              ),
              body: SingleChildScrollView(
                child: Column(
                  children: _listaItems(),
                ),
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
        title: Text(this.data[0].titulo),
      ),
      Divider(),
      ListTile(
        title: Text(this.data[0].descripcion),
      ),
      Divider(),
      ListTile(
        title: FloatingActionButton(
          child: Text("Detalles"),
          onPressed: () {},
        ),
      ),
      Divider(),
      ListTile(
        title: Text("==========================================="),
      ),
      Divider()
    ];
  }
}

//  setState(() {});