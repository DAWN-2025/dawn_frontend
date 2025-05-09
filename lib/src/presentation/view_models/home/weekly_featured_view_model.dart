import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/services.dart';

import '../../../core/utils/log.dart';
import '../../../data/models/event_model.dart';

class WeeklyFeaturedViewModel extends ChangeNotifier {
  Episode? _weekly;

  Episode? get weekly => _weekly;

  Future<void> loadWeeklyEvent() async {
    debugLog('Loading weekly event...');
    final String jsonStr = await rootBundle.loadString(
      'assets/constants/home/home_weekly_card.json',
    );
    final List<dynamic> jsonList = jsonDecode(jsonStr);

    if (jsonList.isNotEmpty) {
      _weekly = Episode.fromJson(jsonList.first);
      debugLog('Weekly event loaded: ${_weekly?.getNameByLocale('en')}');
      notifyListeners();
    } else {
      debugLog('No weekly event found.');
    }
  }
}
