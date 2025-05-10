import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/presentation/widgets/modals/tour_start_modal.dart';
import 'package:dawn_frontend/src/presentation/widgets/modals/delete_comment_modal.dart';

class ExploreNowBtnViewModel extends ChangeNotifier {
  void onTap(BuildContext context) {
    TourStartModal(context);
  }
}
