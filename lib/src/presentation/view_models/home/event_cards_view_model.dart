import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/log.dart';
import '../../../data/models/event_model.dart';

class EventCardsViewModel extends ChangeNotifier {
  List<Episode> _events = [];

  List<Episode> get events => _events;

  Future<void> loadEvents(BuildContext context) async {
    final String jsonStr = await rootBundle.loadString(
      'assets/constants/home/home_events_card.json',
    );
    final List<dynamic> jsonList = jsonDecode(jsonStr);

    _events = jsonList.map((json) => Episode.fromJson(json)).toList();
    debugLog('Loaded ${_events.length} events');
    await Future.wait(
      _events.map(
            (event) => precacheImage(
          CachedNetworkImageProvider(event.eventImage),
          context,
        ),
      ),
    );
    notifyListeners();
  }
}
