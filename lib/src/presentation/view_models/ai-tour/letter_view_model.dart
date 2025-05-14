import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/data/models/letter_model.dart';
import 'package:dawn_frontend/src/domain/repositories/letter_repository.dart';

class LetterViewModel extends ChangeNotifier {
  final LetterRepository _repository = LetterRepository();
  List<Letter> _letters = [];
  bool _isLoading = false;
  String _errorMessage = '';

  List<Letter> get letters => _letters;
  bool get isLoading => _isLoading;
  String get errorMessage => _errorMessage;

  Future<void> loadLetters(int locationSeq) async {
  try {
    final fetchedLetters = await _repository.fetchLetters(locationSeq);
    _letters = fetchedLetters;
    for (var letter in _letters) {
      debugPrint('Letter: $letter');
    }
    notifyListeners();
  } catch (e) {
    debugPrint('ViewModel에서 에러 발생: $e');
  }
}

}
