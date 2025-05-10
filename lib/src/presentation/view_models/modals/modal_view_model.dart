import 'package:flutter/material.dart';

class ModalViewModel extends ChangeNotifier {
  String resultMessage = '';

  void updateMessage(String message) {
    resultMessage = message;
    notifyListeners();
  }

  void closeModal(BuildContext context) {
    Navigator.of(context).pop();
  }
}
