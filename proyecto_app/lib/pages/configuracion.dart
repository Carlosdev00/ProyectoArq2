import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ConfiguracionPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ConfiguracionPageState();
}

class _ConfiguracionPageState extends State<ConfiguracionPage> {
  _logout() async {
    await FirebaseAuth.instance.signOut();
    Navigator.of(context).pushReplacementNamed('/registro');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Confuguracion')),
      body: Center(
        child: FlatButton(
          onPressed: () {
            _logout();
          },
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            children: <Widget>[
              Text(
                'Cerrar sesion',
                style: TextStyle(color: Colors.redAccent),
              ),
              Spacer(),
              Icon(
                Icons.exit_to_app,
                color: Colors.redAccent,
              )
            ],
          ),
        ),
      ),
    );
  }
}
