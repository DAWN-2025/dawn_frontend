import 'package:flutter/foundation.dart';

void debugLog(Object? message) {
  if (kDebugMode) {
    print(message);
  }
}
