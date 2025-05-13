import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

import '../../view_models/map/map_view_model.dart';
import '../../widgets/custom_bottom_app_bar.dart';
import '../../widgets/custom_scaffold.dart';
import '../../widgets/map/map_notice.dart';

class MapScreen extends StatefulWidget {
  static const LatLng _pGWANGFJStation = LatLng(35.1653428, 126.9092003);

  const MapScreen({super.key});

  @override
  State<MapScreen> createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<MapViewModel>().fetchLocationList(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      bottomNavigationBar: const CustomBottomAppBar(),
      body: Consumer<MapViewModel>(
        builder: (context, viewModel, _) {
          return Stack(
            children: [
              // 지도
              GoogleMap(
                initialCameraPosition: const CameraPosition(
                  target: MapScreen._pGWANGFJStation,
                  zoom: 14,
                ),
                markers: viewModel.markers,
                zoomControlsEnabled: false,
                myLocationButtonEnabled: false,
                myLocationEnabled: false,
              ),

              // 상단 배너
              Align(
                alignment: Alignment.topCenter,
                child: MapInfoBanner(
                  locationCount: viewModel.locationList.length,
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
