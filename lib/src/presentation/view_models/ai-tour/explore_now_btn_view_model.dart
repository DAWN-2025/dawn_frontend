import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/presentation/widgets/modals/tour_start_modal.dart';
import 'package:dawn_frontend/src/presentation/widgets/modals/delete_comment_modal.dart';

class ExploreNowBtnViewModel extends ChangeNotifier {
  int? _locationSeq;

  void setLocationSeq(int locationSeq) {
    _locationSeq = locationSeq;
    notifyListeners();
  }

  void onTap(BuildContext context) {
    TourStartModal(context, locationSeq: _locationSeq ?? 1);
  }
}
