import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class DriverHomePage extends StatefulWidget {
  const DriverHomePage({super.key});

  @override
  State<DriverHomePage> createState() => _DriverHomePageState();
}

class _DriverHomePageState extends State<DriverHomePage> {
  late GoogleMapController _mapController;

  // Titik fokus awal Sumedang
  static const CameraPosition _initialCameraPosition = CameraPosition(
    target: LatLng(-6.85904912531052, 107.92101756458817),
    zoom: 14,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('GoAng Driver'),
      ),
      body: GoogleMap(
        initialCameraPosition: _initialCameraPosition,
        onMapCreated: (GoogleMapController controller) {
          _mapController = controller;
        },
        myLocationEnabled: true, 
        myLocationButtonEnabled: true,
        zoomControlsEnabled: false,
        /////// Buat markers
      ),
    );
  }
}
