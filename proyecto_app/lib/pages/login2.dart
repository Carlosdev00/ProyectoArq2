import 'package:flutter/material.dart';
import 'package:proyecto_app/behaviors/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

class LoginPage2 extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _LoginPage2State();
}

class _LoginPage2State extends State<LoginPage2> {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  late String _email;
  late String _password;

  bool _isLogginIn = false;

  _login() async {
    if (_isLogginIn) return;
    setState(() {
      _isLogginIn = true;
    });

    _scaffoldkey.currentState
        ?.showSnackBar(SnackBar(content: Text('Logeando usuario')));

    final form = _formkey.currentState;

    if (!form!.validate()) {
      _scaffoldkey.currentState?.hideCurrentSnackBar();
      setState(() {
        _isLogginIn = false;
      });
      return;
    }

    form.save();

    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: _email, password: _password);
      Navigator.of(context).pop();
      Navigator.of(context).pushReplacementNamed('/hometabs2');
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
        _isLogginIn = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Login TuParking'),
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
                    image: AssetImage('lib/assets/estacionamiento (1).png'),
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
                    "Somos a tu app de parqueaderos de confianza!",
                    style: TextStyle(color: Color.fromARGB(255, 175, 175, 175)),
                  ),
                ),
                FlatButton(
                  child: Text("Olvide mi contraseña"),
                  onPressed: () {
                    Navigator.of(context).pushNamed("/forgotpassword");
                  },
                  textColor: Colors.blueGrey,
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _login();
        },
        child: Icon(Icons.account_box),
      ),
      persistentFooterButtons: <Widget>[
        FlatButton(
            onPressed: () {
              Navigator.of(context).pop();
            },
            child: Text("No tengo cuenta! :c"))
      ],
    );
  }
}
