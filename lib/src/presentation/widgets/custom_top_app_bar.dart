import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import '../../core/theme/colors.dart';
import 'package:go_router/go_router.dart';

class CustomTopAppBar extends StatelessWidget implements PreferredSizeWidget {
  final bool isDark;

  const CustomTopAppBar({super.key, this.isDark = false});

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        height: preferredSize.height,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Align(
          alignment: Alignment.centerLeft,
          child: InkWell(
            onTap: () => context.pop(),
            borderRadius: BorderRadius.circular(30),
            child: Container(
              width: 45,
              height: 45,
              decoration: const ShapeDecoration(
                color: AppColors.backGray,
                shape: OvalBorder(
                  side: BorderSide(color: Colors.white, width: 1),
                ),
              ),
              child: Center(
                child: SvgPicture.asset(
                  isDark
                      ? 'assets/icons/back_dark.svg'
                      : 'assets/icons/back_white.svg',
                  width: 24,
                  height: 24,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(56);
}
