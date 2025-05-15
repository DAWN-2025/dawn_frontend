import 'package:dawn_frontend/src/presentation/widgets/common/image_loader.dart';
import 'package:flutter/material.dart';

class ImageHeader extends StatelessWidget {
  final String imagePath;

  const ImageHeader({
    Key? key,
    required this.imagePath,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ShaderMask(
      shaderCallback: (Rect bounds) {
        return const LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          stops: [0.0, 0.85, 1.0],
          colors: [Colors.white, Colors.white, Colors.transparent],
        ).createShader(bounds);
      },
      blendMode: BlendMode.dstIn,
      child: Container(
        width: double.infinity,
        height: 400,
        child: _buildImage(imagePath),
      ),
    );
  }

  // 이미지 빌드 함수
  Widget _buildImage(String imagePath) {
    const String defaultImage = 'assets/images/default.jpg';

    // URL 교정: PNG 확장자 추가
    final adjustedPath = imagePath.contains('placehold.co') && !imagePath.contains('.png')
        ? '$imagePath.png'
        : imagePath;

    // 네트워크 이미지 처리
    if (adjustedPath.startsWith('http')) {
      print('Loading network image: $adjustedPath');
      return ImageLoader(
        imageUrl: adjustedPath,
        fit: BoxFit.cover,
        headers: const {
          'Accept': 'image/*',  // 이미지 데이터로 인식하도록 설정
        },
      );
    }

    // 로컬 이미지 처리
    print('Loading local image: $imagePath');
    return Image.asset(
      imagePath,
      fit: BoxFit.cover,
      errorBuilder: (context, error, stackTrace) {
        print('Error loading local image: $imagePath');
        return Image.asset(defaultImage, fit: BoxFit.cover);
      },
    );
  }
}
