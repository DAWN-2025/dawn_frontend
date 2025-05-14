import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/stamp_card_view_model.dart';

class StampCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final int eventId;

  const StampCard({
    super.key,
    required this.title,
    this.imagePath,
    required this.eventId,
  });

  @override
  Widget build(BuildContext context) {
    final stampCardViewModel = Provider.of<StampCardViewModel>(context);
    return InkWell(
      onTap: () => stampCardViewModel.handleCardTap(context, eventId),
      borderRadius: BorderRadius.circular(15),
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
        ),
        color: Colors.white.withOpacity(0.2),
        elevation: 0,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              LayoutBuilder(
                builder: (context, constraints) {
                  final size = constraints.maxWidth * 0.95;
                  return ClipRRect(
                    borderRadius: BorderRadius.circular(10),
                    child: SizedBox(
                      width: size,
                      height: size,
                      child:
                          imagePath != null
                              ? Image.network(
                                imagePath!,
                                fit: BoxFit.cover,
                                loadingBuilder: (
                                  BuildContext context,
                                  Widget child,
                                  ImageChunkEvent? loadingProgress,
                                ) {
                                  if (loadingProgress == null) {
                                    return child;
                                  }
                                  return Center(
                                    child: CircularProgressIndicator(
                                      value:
                                          loadingProgress.expectedTotalBytes !=
                                                  null
                                              ? loadingProgress
                                                      .cumulativeBytesLoaded /
                                                  (loadingProgress
                                                          .expectedTotalBytes ??
                                                      1)
                                              : null,
                                    ),
                                  );
                                },
                              )
                              : const Center(child: Text('No Image')),
                    ),
                  );
                },
              ),
              const SizedBox(height: 5),
              Expanded(
                child: Center(
                  child: Text(
                    title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
