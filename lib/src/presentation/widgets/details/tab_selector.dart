// detail_tab_selector.dart
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/tab_selector_view_model.dart';

class DetailTabSelector extends StatelessWidget {
  final List<String> labels;

  const DetailTabSelector({
    super.key,
    required this.labels,
  });

  @override
  Widget build(BuildContext context) {
    
    return Consumer<TabSelectorViewModel>(
      builder: (context, viewModel, child) {
        // 선택한 탭에 따라 그라데이션 방향 설정
        final bool isLeftSelected = viewModel.selectedIndex == 0;

        return Container(
          width: 290,
          height: 39,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            gradient: LinearGradient(
              begin: isLeftSelected ? Alignment.centerLeft : Alignment.centerRight,
              end: isLeftSelected ? Alignment.centerRight : Alignment.centerLeft,
              colors: const [
                Color.fromRGBO(202, 197, 207, 1), // 진한 색
                Colors.white, // 연한 색
              ],
            ),
            boxShadow: [
              BoxShadow(
                color: Colors.grey.withOpacity(0.3),
                blurRadius: 4,
                offset: const Offset(0, 2),
              ),
            ],
            border: Border.all(color: Colors.grey.shade300, width: 1.5),
          ),
          child: Row(
            children: List.generate(labels.length, (index) {
              final bool isSelected = viewModel.selectedIndex == index;

              return Expanded(
                child: GestureDetector(
                  onTap: () => viewModel.setSelectedIndex(index),
                  child: Container(
                    alignment: Alignment.center,
                    height: 39,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(50),
                      color: isSelected
                          ? const Color.fromRGBO(245, 244, 250, 1) // 선택된 배경 색상
                          : Colors.transparent,
                      boxShadow: isSelected
                          ? [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.2),
                                blurRadius: 3,
                                offset: const Offset(0, 1),
                              ),
                            ]
                          : [],
                    ),
                    child: Text(
                      labels[index],
                      style: TextStyle(
                        color: isSelected
                            ? const Color.fromRGBO(30, 30, 30, 1) // 선택된 텍스트 색상
                            : const Color.fromRGBO(183, 183, 183, 1), // 비선택 텍스트 색상
                        fontSize: isSelected ? 17 : 16,
                        fontFamily: 'Noto Serif',
                        fontWeight: isSelected ? FontWeight.w600 : FontWeight.w400,
                      ),
                    ),
                  ),
                ),
              );
            }),
          ),
        );
      },
    );
  }
}
