import 'dart:ffi';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:proyecto_app/models/principalItem.dart';

class PrincipalPage extends StatefulWidget {
  @override
  State<StatefulWidget> createState() => _PrincipalPageState();
}

class _PrincipalPageState extends State<PrincipalPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Pagina inicial')),
      body: Container(child: MapScreen()),
    );
  }
}

class MapScreen extends StatefulWidget {
  const MapScreen({Key? key}) : super(key: key);

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  late final Set<Marker> markeres = new Set();
  static const _posicionInicial =
      CameraPosition(target: LatLng(4.606422, -74.069321), zoom: 15.0);

  late LatLng _posActual = LatLng(4.606422, -74.069321);

  late GoogleMapController _googleMapController;

  Future<void> checkubi() async {
    LocationPermission permission;
    permission = await Geolocator.checkPermission();
    permission = await Geolocator.requestPermission();
    if (permission == await Geolocator.requestPermission()) {
      checkubi();
    }
  }

  @override
  void dispose() {
    _googleMapController.dispose();
    super.dispose();
  }

  @override
  void initState() {
    super.initState();
    Geolocator.getCurrentPosition().then((currLocation) {
      setState(() {
        _posActual = new LatLng(currLocation.latitude, currLocation.longitude);
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    markeres.add(Marker(
      markerId: const MarkerId('id del marker'),
      icon: BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure),
      position: const LatLng(4.606422, -74.069321),
      infoWindow: InfoWindow(
        title: 'Parqueadero don vergas',
        snippet: 'H:8am-8pm/Vehiculos:Carros,Motos/Disponibilidad: si',
      ),
    ));
    return Scaffold(
      body: GoogleMap(
        myLocationEnabled: true,
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        zoomGesturesEnabled: false,
        initialCameraPosition: _posicionInicial,
        onMapCreated: (controller) => _googleMapController = controller,
        markers: markeres,
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.startDocked,
      floatingActionButton: FloatingActionButton(
        backgroundColor: Theme.of(context).primaryColor,
        foregroundColor: Colors.black,
        onPressed: () => _googleMapController.animateCamera(
            CameraUpdate.newCameraPosition(
                CameraPosition(target: _posActual, zoom: 15.0))),
        child: const Icon(Icons.center_focus_strong),
      ),
    );
  }
}
