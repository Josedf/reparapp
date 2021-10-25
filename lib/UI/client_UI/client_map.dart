import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class ClientMap extends StatefulWidget {
  const ClientMap({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<ClientMap> {
  final _initialCameraPosition =
      CameraPosition(target: LatLng(10.786949, -74.753222), zoom: 12);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Maps Sample App'),
        backgroundColor: Color(0xFF7879F1),
      ),
      body: GoogleMap(initialCameraPosition: _initialCameraPosition),
    );
  }
}
