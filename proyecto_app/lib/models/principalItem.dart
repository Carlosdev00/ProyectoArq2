import 'package:cloud_firestore/cloud_firestore.dart';

class PrincipalItem {
  String id = "";
  String title = "";
  String ubi = "";
  String vehiculos = "";

  bool archived = false;
  bool complete = false;

  PrincipalItem(this.title,
      {required this.vehiculos,
      required this.ubi,
      required this.complete,
      required this.archived});

  PrincipalItem.from(DocumentSnapshot snapshot)
      : id = snapshot['title'],
        title = snapshot['title'],
        ubi = snapshot['ubi'],
        vehiculos = snapshot['vehiculos'],
        archived = snapshot['archived'],
        complete = snapshot['complete'];

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'ubi': ubi,
      'vehiculos': vehiculos,
      'complete': complete,
      'archived': archived
    };
  }
}
