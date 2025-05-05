import 'package:dropdown_button2/dropdown_button2.dart';
import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart';

/// MVP에서는 한국어 or English
class LanguageDropdown extends StatefulWidget {
  /// 현재 선택된 언어 값
  final String value;

  /// 언어 선택 변경 시 호출되는 콜백 함수 (부모에게 알림)
  final ValueChanged<String> onChanged;

  const LanguageDropdown({
    super.key,
    required this.value,
    required this.onChanged,
  });

  @override
  State<LanguageDropdown> createState() => _LanguageDropdownState();
}

class _LanguageDropdownState extends State<LanguageDropdown> {
  /// 드롭다운에서 선택할 수 있는 언어 목록 (Menu Items)
  static const List<String> _langs = ['한국어', 'English'];

  @override
  Widget build(BuildContext context) {
    return DropdownButtonHideUnderline(
      // 드롭다운의 기본 밑줄 제거
      child: DropdownButtonFormField2<String>(
        isExpanded: false,
        buttonStyleData: const ButtonStyleData(height: 35, width: 86),
        decoration: InputDecoration(
          filled: true,
          fillColor: Colors.white,
          // hint
          hintText: '언어 선택',
          hintStyle: TextStyle(color: Colors.grey[600]),
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 7,
            vertical: 0,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: const BorderSide(color: Colors.transparent, width: 1),
          ),
        ),
        //------------------------------
        dropdownStyleData: DropdownStyleData(
          maxHeight: 120,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(5),
            color: Colors.white,
          ),
        ),
        menuItemStyleData: const MenuItemStyleData(
          height: 30,
          padding: EdgeInsets.only(left: 7, right: 0),
        ),
        items:
            _langs.map((lang) {
              return DropdownMenuItem<String>(
                value: lang,
                child: Container(
                  height: 30,
                  alignment: Alignment.centerLeft,
                  child: Text(
                    lang,
                    style: AppTextStyle.bodyTextPoppins.copyWith(
                      fontSize: 12,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ),
              );
            }).toList(),
        value: widget.value.isEmpty ? null : widget.value,
        onChanged: (selected) {
          if (selected != null) widget.onChanged(selected);
        },
      ),
    );
  }
}
