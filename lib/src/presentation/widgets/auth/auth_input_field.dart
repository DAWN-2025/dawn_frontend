import 'package:dawn_frontend/src/core/theme/colors.dart';
import 'package:flutter/material.dart';

class AuthInputField extends StatelessWidget {
  final Widget icon;
  final bool obscure; // 글자 숨김 여부
  final ValueChanged<String?> onChanged; // 텍스트 변경 시 호출되는 콜백
  final FocusNode? focusNode;

  const AuthInputField({
    super.key,
    required this.icon,
    this.obscure = false,
    required this.onChanged,
    this.focusNode,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48, // 높이 조정
      width: double.infinity, // 너비를 부모 기준으로 최대
      child: TextFormField(
        obscureText: obscure,
        onChanged: onChanged, // 텍스트 변경 시 호출되는 콜백,
        focusNode: focusNode, // 포커스 노드 추가
        decoration: InputDecoration(
          // 왼쪽 아이콘
          prefixIcon: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: icon,
          ),

          // 아이콘 위치 제대로 맞추기 위해 prefixIconConstraints 조정
          prefixIconConstraints: const BoxConstraints(
            minWidth: 15,
            minHeight: 15,
          ),

          filled: true,
          fillColor: AppColors.lightGray,

          // 텍스트와 입력칸 여백 조정
          contentPadding: const EdgeInsets.symmetric(
            vertical: 6, // 텍스트 위아래 간격
            //horizontal: 8, // 텍스트 왼쪽 간격
          ),

          // 테두리
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(5),
            borderSide: BorderSide.none, // 기본 테두리 제거 (깔끔한 스타일용)
          ),
        ),
        style: const TextStyle(fontSize: 14), // 텍스트 크기
      ),
    );
  }
}
