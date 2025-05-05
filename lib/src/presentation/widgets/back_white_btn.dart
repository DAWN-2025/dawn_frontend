import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

import '../../core/theme/colors.dart';

class BackWhiteBtn extends StatelessWidget {
  final VoidCallback onPressed;

  const BackWhiteBtn({super.key, required this.onPressed});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      borderRadius: BorderRadius.circular(30),
      child: Container(
        width: 44,
        height: 44,
        decoration: BoxDecoration(
          color: AppColors.backGray,
          shape: BoxShape.circle,
          border: Border.all(color: Colors.white, width: 1),
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
            'assets/icons/back_white.svg',
            width: 24,
            height: 24,
          ),
        ),
      ),
    );
  }
}
