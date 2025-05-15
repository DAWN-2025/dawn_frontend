import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:shimmer/shimmer.dart';

class ImageLoader extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final Color? color;
  final BlendMode? colorBlendMode;
  final Map<String, String>? headers;

  const ImageLoader({
    Key? key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.color,
    this.colorBlendMode,
    this.headers,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      child: ColorFiltered(
        colorFilter:
            color != null && colorBlendMode != null
                ? ColorFilter.mode(color!, colorBlendMode!)
                : const ColorFilter.mode(Colors.transparent, BlendMode.srcOver),
        child: CachedNetworkImage(
          imageUrl: imageUrl,
          width: width,
          height: height,
          fit: fit,
          color: color,
          colorBlendMode: colorBlendMode,
          httpHeaders: headers,
          placeholder: (context, url) => _shimmerPlaceholder(),
          errorWidget: (context, url, error) => _shimmerPlaceholder(),
          imageBuilder:
              (context, imageProvider) => Container(
                decoration: BoxDecoration(
                  image: DecorationImage(image: imageProvider, fit: fit),
                ),
              ),
        ),
      ),
    );
  }

  // ✅ Shimmer를 사용한 로딩 및 에러 상태 표시
  Widget _shimmerPlaceholder() {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!,
      highlightColor: Colors.grey[100]!,
      child: Container(
        width: width ?? double.infinity,
        height: height ?? double.infinity,
        color: Colors.grey[300],
        alignment: Alignment.center,
        child: const Text(
          'Loading...',
          style: TextStyle(fontSize: 14, color: Colors.white),
        ),
      ),
    );
  }
}
