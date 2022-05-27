import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

class DatosPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _DatosPageState();
}

class _DatosPageState extends State<DatosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pagina datos')),
      body: Center(
        child: AddData(),
      ),
    );
  }
}

class AddData1 extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: FloatingActionButton(
        backgroundColor: Colors.green,
        child: Icon(Icons.add),
        onPressed: () {
          FirebaseFirestore.instance
              .collection('data')
              .doc(FirebaseAuth.instance.currentUser?.uid)
              .set({'text': 'data added through app2', 'descripcion': 'weno'});
        },
      ),
    );
  }
}

class AddData extends StatelessWidget {
  List<String> daticos = [];
  String prueba = "";
  @override
  Widget build(BuildContext context) {
    return Center(
      child: StreamBuilder(
        stream: FirebaseFirestore.instance.collection('data').snapshots(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          return ListView(
            children: snapshot.data!.docs.map((document) {
              daticos.add(document['text']);
              print(daticos);
              return Container(
                child: Center(child: Text(document['text'])),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
