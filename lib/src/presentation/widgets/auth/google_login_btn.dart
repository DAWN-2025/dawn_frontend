import 'package:dawn_frontend/src/core/theme/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class GoogleLoginBtn extends StatelessWidget {
  final VoidCallback onPressed;

  const GoogleLoginBtn({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: Colors.white,
          shape: BoxShape.circle,
          border: Border.all(color: AppColors.darkGray),
          /*boxShadow: [
            BoxShadow(
              color: Colors.black12,
              blurRadius: 2,
              offset: Offset(0, 1),
            ),
          ],*/
        ),
        child: Center(
          child: SvgPicture.asset(
            'assets/icons/google.svg', // 구글 아이콘 경로
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
