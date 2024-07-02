import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:flutter/gestures.dart';

class MapViewer extends StatelessWidget {
  final double latitude;
  final double longitude;

  const MapViewer({
    Key? key,
    required this.latitude,
    required this.longitude,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300, // Adjust the height as needed
      margin: const EdgeInsets.all(20),
      width: double.infinity,
      decoration: BoxDecoration(
        border: Border.all(color: Colors.white, width: 2),
        borderRadius: BorderRadius.circular(15),
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(15),
        child: GoogleMap(
          mapType: MapType.satellite,
          indoorViewEnabled: true,
          initialCameraPosition: CameraPosition(
            target: LatLng(latitude, longitude),
            zoom: 14,
          ),
          markers: {
            Marker(
              markerId: MarkerId('selected-location'),
              position: LatLng(latitude, longitude),
            ),
          },
          gestureRecognizers: Set()
            ..add(Factory<PanGestureRecognizer>(() => PanGestureRecognizer()))
            ..add(
                Factory<ScaleGestureRecognizer>(() => ScaleGestureRecognizer()))
            ..add(Factory<TapGestureRecognizer>(() => TapGestureRecognizer()))
            ..add(Factory<VerticalDragGestureRecognizer>(
                () => VerticalDragGestureRecognizer())),
        ),
      ),
    );
  }
}
