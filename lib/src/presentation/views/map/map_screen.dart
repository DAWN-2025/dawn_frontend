import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

import '../../widgets/custom_bottom_app_bar.dart';
import '../../widgets/custom_scaffold.dart';

class MapScreen extends StatelessWidget {
  static const LatLng _pGwangjuStation = LatLng(35.1653428, 126.9092003);

  const MapScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: const CustomBottomAppBar(),
      body: GoogleMap(
        initialCameraPosition: const CameraPosition(
          target: _pGwangjuStation,
          zoom: 14,
        ),
        zoomControlsEnabled: false,
        myLocationButtonEnabled: false,
      ),
    );
  }
}
