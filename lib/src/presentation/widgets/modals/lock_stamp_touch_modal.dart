import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/modals/modal_view_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/modals/reusable_modal.dart';
import 'package:go_router/go_router.dart';

class LockStampTouchModal extends StatelessWidget {
  final String navigationPath;
  const LockStampTouchModal({
    Key? key,
    required this.navigationPath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ModalViewModel>(context, listen: false);

    return ReusableModal(
      title: 'Locked Stamp!\nYou can unlock it to start AI tour in relevant locations.\nWould you like to check the event?',
      primaryButtonText: 'Check the event',
      secondaryButtonText: 'Cancel',
      onPrimaryPressed: () {
        context.push(navigationPath);
      },
      onSecondaryPressed: () {
        viewModel.closeModal(context);
      },
    );
  }
}
