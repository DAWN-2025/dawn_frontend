import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../viewmodels/custom_bottom_app_bar_viewmodel.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:go_router/go_router.dart';

class CustomBottomAppBar extends StatelessWidget {
  final List<_BottomAppBarItem> items = [
    _BottomAppBarItem('assets/icons/home.svg', 0, '/'),
    _BottomAppBarItem('assets/icons/map.svg', 1, '/map'),
    _BottomAppBarItem('assets/icons/album.svg', 2, '/album'),
    _BottomAppBarItem('assets/icons/setting.svg', 3, '/setting'),
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<BottomAppBarViewModel>(
      builder: (context, viewModel, child) {
        return BottomAppBar(
          shape: CircularNotchedRectangle(),
          elevation: 10,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children:
                items.map((item) {
                  return IconButton(
                    icon: SvgPicture.asset(
                      item.iconPath,
                      color:
                          viewModel.selectedIndex == item.index
                              ? Colors.blue
                              : Colors.grey,
                    ),
                    onPressed: () {
                      viewModel.onItemTapped(item.index);
                      context.go(item.route);
                    },
                  );
                }).toList(),
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

  _BottomAppBarItem(this.iconPath, this.index, this.route);
}
