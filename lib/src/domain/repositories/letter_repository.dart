import 'package:dawn_frontend/src/data/models/letter_model.dart';
import 'package:dawn_frontend/src/data/services/letter_service.dart';

class LetterRepository {
  final LetterService _letterService = LetterService();

  Future<List<Letter>> fetchLetters(int locationSeq) async {
    try {
      final letters = await _letterService.fetchLettersByLocation(locationSeq);
      if (letters.isNotEmpty) {
        return letters;
      } else {
        print('Repository: No letters found');
        return [];
      }
    } catch (e) {
      print('Error fetching letters in repository: $e');
      return [];
    }
  }
}
