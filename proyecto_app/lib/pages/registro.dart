import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_app/behaviors/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

class RegistroPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _RegistroPageState();
}

class _RegistroPageState extends State<RegistroPage> {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  late String _email;
  late String _password;

  bool _isRegistering = false;

  _registro() async {
    if (_isRegistering) return;
    setState(() {
      _isRegistering = true;
    });

    _scaffoldkey.currentState
        ?.showSnackBar(SnackBar(content: Text('Registrando usuario')));

    final form = _formkey.currentState;

    if (!form!.validate()) {
      _scaffoldkey.currentState?.hideCurrentSnackBar();
      setState(() {
        _isRegistering = false;
      });
      return;
    }

    form.save();

    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pushReplacementNamed('/hometabs');
    } catch (e) {
      //print(e);
      _scaffoldkey.currentState?.hideCurrentSnackBar();
      _scaffoldkey.currentState?.showSnackBar(SnackBar(
        content: Text(e.toString()),
        duration: Duration(seconds: 10),
        action: SnackBarAction(
          label: 'De acuerdo',
          onPressed: () {
            _scaffoldkey.currentState?.hideCurrentSnackBar();
          },
        ),
      ));
    } finally {
      setState(() {
        _isRegistering = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Registro'),
      ),
      body: Container(
        padding: EdgeInsets.all(20.0),
        child: ScrollConfiguration(
          behavior: HiddenScrollBehavior(),
          child: Form(
            key: _formkey,
            child: ListView(
              children: <Widget>[
                Image(
                    image: AssetImage('lib/assets/parking-de-bicicletas.png'),
                    height: 200),
                TextFormField(
                  autocorrect: false,
                  keyboardType: TextInputType.emailAddress,
                  decoration: InputDecoration(labelText: 'Email'),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Porfavor ingrese un corre valido';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      _email = val!;
                    });
                  },
                ),
                TextFormField(
                  obscureText: true,
                  decoration: InputDecoration(labelText: 'Contraseña'),
                  validator: (val) {
                    if (val!.isEmpty) {
                      return 'Porfavor ingrese una clave valida';
                    } else {
                      return null;
                    }
                  },
                  onSaved: (val) {
                    setState(() {
                      _password = val!;
                    });
                  },
                ),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text(
                    "Bienvenido a tu app favorita de parqueaderos!",
                    style: TextStyle(color: Color.fromARGB(255, 175, 175, 175)),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _registro();
        },
        child: Icon(Icons.account_circle),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/login");
            },
            child: Text("Ya tengo una cuenta!")),
        FlatButton(
            onPressed: () {
              Navigator.of(context).pushNamed("/registro2");
            },
            child: Text("Usuario TuParking!")),
      ],
    );
  }
}
