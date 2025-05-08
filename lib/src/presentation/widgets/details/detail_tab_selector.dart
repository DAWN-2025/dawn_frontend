import 'package:flutter/material.dart';

class DetailTabSelector extends StatelessWidget {
  final List<String> labels;
  final int selectedIndex;
  final Function(int) onTap;

  const DetailTabSelector({
    Key? key,
    required this.labels,
    required this.selectedIndex,
    required this.onTap,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 290,
      height: 39,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(50),
        color: Color.fromRGBO(202, 197, 207, 1),
        // gradient: LinearGradient(
        //   begin: Alignment.centerLeft,
        //   end: Alignment.centerRight,
        //   colors: const [
        //     Color.fromRGBO(202, 197, 207, 1), // 진한 색
        //     Colors.white, // 연한 색
        //   ],
        // ),
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
          final bool isSelected = selectedIndex == index;

          return Expanded(
            child: GestureDetector(
              onTap: () {
                print("Tab clicked: $index");  // 디버깅용
                onTap(index);  // 콜백 호출
              },
              child: Container(
                alignment: Alignment.center,
                height: 39,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(50),
                  color: isSelected
                      ? const Color.fromARGB(255, 255, 255, 255) // 선택된 배경 색상
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
                        : const Color.fromRGBO(100, 100, 100, 1), // 비선택 텍스트 색상
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
  }
}
