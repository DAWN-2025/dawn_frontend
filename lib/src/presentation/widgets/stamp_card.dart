import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';
import '../view_models/stamp_card_view_model.dart';

class StampCard extends StatelessWidget {
  final StampCardViewModel viewModel;

  const StampCard({super.key, required this.viewModel});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () async {
        await viewModel.handleCardTap(viewModel.id);
        context.go(viewModel.navigationPath.value);
        viewModel.clearNavigation();
      },
      borderRadius: BorderRadius.circular(15), // 터치 효과의 경계 설정
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
          side: BorderSide(color: Colors.white.withOpacity(0.5), width: 1),
        ),
        color: Colors.white.withOpacity(0.2),
        elevation: 0, // 그림자 깊이
        child: Padding(
          padding: const EdgeInsets.all(8.0), // 카드 내부 여백
          child: Column(
            mainAxisSize: MainAxisSize.max,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              // 이미지 영역
              ClipRRect(
                child: SizedBox(
                  width: 135,
                  height: 135,
                  child:
                      viewModel.imagePath != null
                          ? SvgPicture.asset(
                            viewModel.imagePath!,
                            fit: BoxFit.cover,
                          )
                          : const Center(child: Text('No Image')),
                ),
              ),
              const SizedBox(height: 5), // 이미지와 텍스트 간격

              Expanded(
                child: Center(
                  child: Text(
                    viewModel.title,
                    style: const TextStyle(
                      fontSize: 13,
                      fontWeight: FontWeight.bold,
                      color: Colors.white,
                    ),
                    textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis, // 텍스트가 길어지면 생략 부호 표시
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
