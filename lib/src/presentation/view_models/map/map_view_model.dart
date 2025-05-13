import 'package:flutter/material.dart';
import 'package:geocoding/geocoding.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/data/services/map_service.dart';
import 'package:dawn_frontend/src/core/utils/log.dart';
import 'package:dawn_frontend/src/data/models/map/map_location.dart';
import 'package:dawn_frontend/src/presentation/view_models/language_view_model.dart';

import '../../widgets/map/map_location_preview_card.dart';

class MapViewModel extends ChangeNotifier {
  final MapService _mapService = MapService();

  bool _isLoading = false;

  bool get isLoading => _isLoading;

  List<MapLocationDTO> _locationList = [];

  List<MapLocationDTO> get locationList => _locationList;

  final Set<Marker> _markers = {};

  Set<Marker> get markers => _markers;

  Future<void> fetchLocationList(BuildContext context) async {
    _isLoading = true;
    notifyListeners();

    final locations = await _mapService.fetchLocationList();
    _locationList = locations;

    _markers.clear();

    for (var location in locations) {
      final address = location.address;

      try {
        List<Location> geoResult = await locationFromAddress(address);
        if (geoResult.isNotEmpty) {
          final latLng = LatLng(geoResult[0].latitude, geoResult[0].longitude);

          _markers.add(
            Marker(
              markerId: MarkerId(location.id.toString()),
              position: latLng,
              onTap: () {
                _showLocationPreview(context, location);
              },
            ),
          );
        }
      } catch (e) {
        debugLog('주소 변환 실패: $address → $e');
      }
    }

    _isLoading = false;
    notifyListeners();
  }

  void _showLocationPreview(BuildContext context, MapLocationDTO location) {
    final locale = context.read<LanguageViewModel>().currentLocale;
    final isKorean = locale.languageCode == 'ko';
    final localizedName = isKorean ? location.name : location.nameEng;

    showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      builder: (_) {
        return Padding(
          padding: const EdgeInsets.only(
            left: 24,
            right: 24,
            bottom: 95,
          ),
          child: MapLocationPreviewCard(
            imageUrl: location.imageUrl,
            name: localizedName,
            locationId: location.id,
          ),
        );
      },
    );
  }
}
