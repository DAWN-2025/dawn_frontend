import 'package:flutter/material.dart';

class DetailTabSelector extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final void Function(int) onTap;

  const DetailTabSelector({
    super.key,
    required this.labels,
    required this.selectedIndex,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // 선택한 탭에 따라 그라데이션 방향 변경
    final bool isLeftSelected = selectedIndex == 0;

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
        border: Border.all(color: Colors.grey.shade300),
      ),
      child: Row(
        children: List.generate(labels.length, (index) {
          final bool isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () => onTap(index),
              child: Container(
                alignment: Alignment.center,
                height: 39,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: Colors.transparent,
                ),
                child: Text(
                  labels[index],
                  style: TextStyle(
                    color: isSelected ? Colors.black : const Color.fromRGBO(183,183,183,1),
                    fontSize: 16,
                    fontFamily: 'Noto Serif',
                    fontWeight: FontWeight.w500,
                  ),
                ),
              ),
            ),
          );
        }),
      ),
    );
  }
}
