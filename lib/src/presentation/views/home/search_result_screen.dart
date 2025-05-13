import 'package:flutter/material.dart';

class SearchResultScreen extends StatelessWidget {
  const SearchResultScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('검색 결과'),
        centerTitle: true,
      ),
      body: const Center(
        child: Text(
          '검색 결과가 여기에 표시됩니다.',
          style: TextStyle(fontSize: 16),
        ),
      ),
    );
  }
}
