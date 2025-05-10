import 'dart:nativewrappers/_internal/vm/lib/ffi_native_type_patch.dart';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/modals/modal_view_model.dart';

class ReusableModal extends StatelessWidget {
  final String title;
  final String primaryButtonText;
  final String secondaryButtonText;
  final VoidCallback onPrimaryPressed;
  final VoidCallback onSecondaryPressed;
  final String? bottomText;
  final VoidCallback? onBottomTextPressed;

  const ReusableModal({
    Key? key,
    required this.title,
    required this.primaryButtonText,
    required this.secondaryButtonText,
    required this.onPrimaryPressed,
    required this.onSecondaryPressed,
    this.bottomText,
    this.onBottomTextPressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final viewModel = Provider.of<ModalViewModel>(context, listen: false);

    return Theme(
      data: ThemeData(useMaterial3: false),
      child: Dialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
        backgroundColor: Colors.white,
        elevation: 10,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(25),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const SizedBox(height: 45),
                  Text(
                    title,
                    textAlign: TextAlign.center,
                    style: const TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 30),

                  ElevatedButton(
                    onPressed: () {
                      onPrimaryPressed();
                      viewModel.closeModal(context);
                    },
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 45),
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.black,
                      side: BorderSide(color: Colors.black),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(primaryButtonText),
                  ),
                  const SizedBox(height: 10),

                  ElevatedButton(
                    onPressed: () => viewModel.closeModal(context),
                    style: ElevatedButton.styleFrom(
                      minimumSize: const Size(double.infinity, 45),
                      backgroundColor: Color.fromRGBO(104, 84,104,1),
                      foregroundColor: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(15),
                      ),
                    ),
                    child: Text(secondaryButtonText),
                  ),
                  if (bottomText != null) ...[
                    const SizedBox(height: 20),
                    GestureDetector(
                      onTap: onBottomTextPressed,
                      child: Text(
                        bottomText!,
                        style: const TextStyle(
                          fontSize: 14,
                          color: Colors.black,
                          decoration: TextDecoration.underline,
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
            Positioned(
              right: 5,
              top: 5,
              child: IconButton(
                icon: const Icon(Icons.close),
                color: Colors.grey,
                onPressed: () => viewModel.closeModal(context),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
