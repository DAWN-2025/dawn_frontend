import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class StampCardViewModel extends ChangeNotifier {
  String? navigationPath;

  void handleCardTap(BuildContext context, int eventId) {
    navigationPath = '/event-detail/$eventId';
    if (navigationPath != null) {
      context.push(navigationPath!);
    }
    notifyListeners();
  }

  void clearNavigation() {
    navigationPath = null;
    notifyListeners();
  }
}
