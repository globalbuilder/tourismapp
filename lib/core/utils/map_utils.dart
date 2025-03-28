import 'package:google_maps_flutter/google_maps_flutter.dart';

Marker createMarker({
  required String markerId,
  required double lat,
  required double lng,
  String? title,
  String? snippet,
}) {
  return Marker(
    markerId: MarkerId(markerId),
    position: LatLng(lat, lng),
    infoWindow: InfoWindow(
      title: title,
      snippet: snippet,
    ),
  );
}
