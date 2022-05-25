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
        child: Text('Esta es la pagina Datos'),
      ),
    );
  }
}
