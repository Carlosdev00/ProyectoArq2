import 'package:flutter/material.dart';
import 'package:proyecto_app/behaviors/hiddenScrollBehavior.dart';
import 'package:firebase_auth/firebase_auth.dart';

class ForgotPasswordPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _formkey = GlobalKey<FormState>();
  final _scaffoldkey = GlobalKey<ScaffoldState>();

  late String _email;

  bool _isSendingForgotPassword = false;

  _forgotPassword() async {
    if (_isSendingForgotPassword) return;
    setState(() {
      _isSendingForgotPassword = true;
    });

    _scaffoldkey.currentState
        ?.showSnackBar(SnackBar(content: Text('Validando correo')));

    final form = _formkey.currentState;

    if (!form!.validate()) {
      _scaffoldkey.currentState?.hideCurrentSnackBar();
      setState(() {
        _isSendingForgotPassword = false;
      });
      return;
    }

    form.save();

    try {
      await FirebaseAuth.instance.sendPasswordResetEmail(email: _email);
      _scaffoldkey.currentState?.hideCurrentSnackBar();
      _scaffoldkey.currentState?.showSnackBar(SnackBar(
        content: Text('Contraseña cambiada, revise el buzon de su correo.'),
        duration: Duration(seconds: 10),
      ));
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
        _isSendingForgotPassword = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: _scaffoldkey,
      appBar: AppBar(
        title: Text('Cambio clave'),
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
                    image: AssetImage('lib/assets/password_icon_183875.ico'),
                    height: 200),
                Padding(
                  padding: EdgeInsets.symmetric(vertical: 20.0),
                  child: Text('Porfavor ingrese su correo registrado'),
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: 'Email'),
                  keyboardType: TextInputType.emailAddress,
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
                )
              ],
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          _forgotPassword();
        },
        child: Icon(Icons.restore),
      ),
    );
  }
}
