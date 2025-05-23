import 'package:dawn_frontend/src/presentation/widgets/common/image_loader.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/stamp_card_view_model.dart';

class StampCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final int eventId;
  final bool isVisited;

  const StampCard({
    super.key,
    required this.title,
    this.imagePath,
    required this.eventId,
    required this.isVisited,
  });

  @override
  Widget build(BuildContext context) {
    final stampCardViewModel = Provider.of<StampCardViewModel>(context);
    return InkWell(
      onTap:
          () => stampCardViewModel.handleCardTap(context, eventId, isVisited),
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
                    child: Stack(
                      children: [
                        // 이미지 로드
                        SizedBox(
                          width: size,
                          height: size,
                          child:
                              imagePath != null
                                  ? ImageLoader(
                                    imageUrl: imagePath!,
                                    fit: BoxFit.cover,
                                    color:
                                        isVisited
                                            ? null
                                            : Colors.black.withOpacity(0.8),
                                    colorBlendMode:
                                        isVisited ? null : BlendMode.darken,
                                  )
                                  : const Center(child: Text('No Image')),
                        ),

                        // 방문하지 않았을 때 자물쇠 아이콘 표시
                        if (!isVisited)
                          Positioned.fill(
                            child: Center(
                              child: Icon(
                                Icons.lock,
                                color: Colors.white,
                                size: 24,
                              ),
                            ),
                          ),
                      ],
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
