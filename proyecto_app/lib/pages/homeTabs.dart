import 'package:flutter/material.dart';
import 'package:proyecto_app/pages/configuracion.dart';
import 'package:proyecto_app/pages/datos.dart';
import 'package:proyecto_app/pages/principal.dart';

class HomeTabsPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: DefaultTabController(
        length: 2,
        child: new Scaffold(
          body: TabBarView(children: <Widget>[
            PrincipalPage(),
            ConfiguracionPage(),
          ]),
          bottomNavigationBar: PreferredSize(
            preferredSize: Size(60.0, 60.0),
            child: Container(
              height: 60.0,
              child: TabBar(
                labelColor: Theme.of(context).primaryColor,
                labelStyle: TextStyle(fontSize: 10.0),
                tabs: <Widget>[
                  Tab(
                    icon: Icon(Icons.list),
                    text: 'Home',
                  ),
                  Tab(
                    icon: Icon(Icons.settings),
                    text: 'Configuracion',
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
