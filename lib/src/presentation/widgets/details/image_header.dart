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
        decoration: BoxDecoration(
          image: DecorationImage(
            image: AssetImage(imagePath),
            fit: BoxFit.cover,
            onError: (error, stackTrace) {
              debugPrint("Error loading image: $error");
            },
          ),
        ),
      ),
    );
  }
}
