
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:geolocator/geolocator.dart';
import '../services/location_service.dart';

class TrackingScreen extends StatefulWidget {
  final int loanId;

  TrackingScreen({required this.loanId});

  @override
  _TrackingScreenState createState() => _TrackingScreenState();
}

class _TrackingScreenState extends State<TrackingScreen> {
  GoogleMapController? mapController;
  LatLng? _currentPosition;

  @override
  void initState() {
    super.initState();
    _trackLocation();
  }

  void _trackLocation() async {
    Geolocator.getPositionStream().listen((Position pos) {
      setState(() {
        _currentPosition = LatLng(pos.latitude, pos.longitude);
      });
      LocationService.sendLocation(widget.loanId, pos.latitude, pos.longitude);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Lacak Mobil')),
      body: _currentPosition == null
          ? Center(child: CircularProgressIndicator())
          : GoogleMap(
              initialCameraPosition: CameraPosition(target: _currentPosition!, zoom: 16),
              markers: {
                Marker(
                  markerId: MarkerId('mobil'),
                  position: _currentPosition!,
                )
              },
              onMapCreated: (controller) => mapController = controller,
            ),
    );
  }
}
