import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:proyecto_app/pages/homeTabs.dart';
import 'package:proyecto_app/pages/registro.dart';
import 'package:proyecto_app/routes.dart';
import 'package:proyecto_app/theme.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(ProyectoApp());
}

class ProyectoApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _ProyectoAppState();
}

class _ProyectoAppState extends State<ProyectoApp> {
  Widget rootPage = RegistroPage();
  Future<Widget> getRootPage() async =>
      await FirebaseAuth.instance.currentUser! == null
          ? RegistroPage()
          : HomeTabsPage();

  @override
  void initState() {
    super.initState();
    getRootPage().then((Widget page) {
      setState(() {
        rootPage = page;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Proyecto App',
      home: rootPage,
      routes: buildAppRoutes(),
      theme: buildAppTheme(),
    );
  }
}
