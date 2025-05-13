import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class StampCard extends StatelessWidget {
  final String title;
  final String? imagePath;
  final VoidCallback onTap;

  const StampCard({
    super.key,
    required this.title,
    this.imagePath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
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
                      child: imagePath != null
                          ? SvgPicture.asset(
                              imagePath!,
                              fit: BoxFit.cover,
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
