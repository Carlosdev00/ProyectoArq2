import 'package:flutter/material.dart';
import 'package:proyecto_app/pages/forgotPassword.dart';
import 'package:proyecto_app/pages/homeTabs.dart';
import 'package:proyecto_app/pages/homeTabs2.dart';
import 'package:proyecto_app/pages/login.dart';
import 'package:proyecto_app/pages/login2.dart';
import 'package:proyecto_app/pages/registro.dart';
import 'package:proyecto_app/pages/registro2.dart';

Map<String, WidgetBuilder> buildAppRoutes() {
  return {
    '/login': (BuildContext context) => LoginPage(),
    '/login2': (BuildContext context) => LoginPage2(),
    '/registro': (BuildContext context) => RegistroPage(),
    '/registro2': (BuildContext context) => RegistroPage2(),
    '/forgotpassword': (BuildContext context) => ForgotPasswordPage(),
    '/hometabs': (BuildContext context) => HomeTabsPage(),
    '/hometabs2': (BuildContext context) => HomeTabs2Page(),
  };
}
