import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import '../view_models/stamp_card_list_view_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/modals/lock_stamp_touch_modal.dart';
import 'package:dawn_frontend/src/data/models/stamp_card_model.dart';

class StampCardViewModel extends ChangeNotifier {
  final StampCardListViewModel stampCardListViewModel;

  StampCardViewModel(this.stampCardListViewModel);

  void handleCardTap(BuildContext context, int eventId, bool isVisited) {
  String navigationPath = '/event-detail/$eventId';

  if (isVisited) {
    context.push(navigationPath);
  } else {
    showDialog(
      context: context,
      builder: (context) => LockStampTouchModal(
        navigationPath: navigationPath,
      ),
    );
  }
}

}
