import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/ai-tour/letter_view_model.dart';

class LetterScreen extends StatefulWidget {
  final int locationSeq;

  const LetterScreen({Key? key, required this.locationSeq}) : super(key: key);

  @override
  _LetterScreenState createState() => _LetterScreenState();
}

class _LetterScreenState extends State<LetterScreen> {
  @override
  void initState() {
    super.initState();
    // 화면이 생성될 때 데이터 로드
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LetterViewModel>().loadLetters(widget.locationSeq);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Check Letters')),
      body: Consumer<LetterViewModel>(
        builder: (context, viewModel, child) {
          print('ViewModel Letters: ${viewModel.letters}'); // 디버깅

          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(viewModel.errorMessage));
          }

          if (viewModel.letters.isEmpty) {
            return const Center(child: Text('No letters found'));
          }

          return ListView.builder(
            itemCount: viewModel.letters.length,
            itemBuilder: (context, index) {
              final letter = viewModel.letters[index];
              print('Letter at index $index: ${letter.toString()}'); // 디버깅

              return ListTile(
                title: Text(letter.content),
                subtitle: Text('Time: ${letter.letterTime}'),
              );
            },
          );
        },
      ),
    );
  }
}
