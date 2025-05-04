import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import '../viewmodels/custom_bottom_app_bar_viewmodel.dart';
import '../../core/theme/colors.dart';

class CustomBottomAppBar extends StatelessWidget {
  final List<_BottomAppBarItem> items = const [
    _BottomAppBarItem('assets/icons/home.svg', 0, '/'),
    _BottomAppBarItem('assets/icons/map.svg', 1, '/map'),
    _BottomAppBarItem('assets/icons/album.svg', 2, '/album'),
    _BottomAppBarItem('assets/icons/setting.svg', 3, '/setting'),
  ];

  const CustomBottomAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomAppBarViewModel>(
      builder: (context, viewModel, child) {
        return Container(
          decoration: const BoxDecoration(
            border: Border(top: BorderSide(color: Colors.white, width: 0.5)),
            color: Colors.black12,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(50),
              topRight: Radius.circular(50),
            ),
          ),
          child: BottomAppBar(
            shape: const CircularNotchedRectangle(),
            elevation: 10,
            color: Colors.transparent,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children:
                  items.map((item) {
                    return IconButton(
                      icon: SvgPicture.asset(
                        item.iconPath,
                        color:
                            viewModel.selectedIndex == item.index
                                ? Colors.white
                                : AppColors.darkGray,
                      ),
                      onPressed: () {
                        viewModel.onItemTapped(item.index);
                        context.go(item.route);
                      },
                    );
                  }).toList(),
            ),
          ),
        );
      },
    );
  }
}

class _BottomAppBarItem {
  final String iconPath;
  final int index;
  final String route;

  const _BottomAppBarItem(this.iconPath, this.index, this.route);
}
