import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:go_router/go_router.dart';
import 'package:dawn_frontend/src/presentation/view_models/ai-tour/letter_view_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/common/custom_top_app_bar.dart';
import 'package:dawn_frontend/src/presentation/widgets/common/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/go_to_detail_btn.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

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
    return CustomScaffold(
      appBar: CustomTopAppBar(),
      body: Consumer<LetterViewModel>(
        builder: (context, viewModel, child) {
          // 로딩 상태 또는 데이터가 없는 경우 로딩 스피너 표시
          if (viewModel.isLoading || viewModel.letters.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          // 오류 메시지가 있는 경우 화면에 표시
          if (viewModel.errorMessage.isNotEmpty) {
            return Center(child: Text(viewModel.errorMessage));
          }

          // 데이터가 정상적으로 로드된 경우
          final letter = viewModel.letters.first;

          return SizedBox.expand(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween, // 위아래 공간 분리
              children: [
                SizedBox(height: MediaQuery.of(context).size.height * 0.1),
                Expanded(
                  child: Center(
                    child: Container(
                      width: MediaQuery.of(context).size.width * 0.9,
                      constraints: BoxConstraints(
                        minHeight: 100, // 최소 높이 설정
                        maxHeight: MediaQuery.of(context).size.height * 0.65,
                      ),
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(20),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.black.withOpacity(0.2),
                            blurRadius: 8,
                            offset: const Offset(0, 4),
                          ),
                        ],
                      ),
                      child: SingleChildScrollView(
                        child: ConstrainedBox(
                          constraints: BoxConstraints(
                            minHeight: MediaQuery.of(context).size.height * 0.5, // 스크롤뷰 높이 지정
                          ),
                          child: IntrinsicHeight(
                            // 자식 요소의 최소 높이를 계산하여 레이아웃 문제 방지
                            child: Text(
                              letter.content.isNotEmpty ? letter.content : '',
                              textAlign: TextAlign.start,
                              style: typography.AppTextStyle.bodyText.copyWith(
                                fontStyle: FontStyle.italic,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),

                GoToDetailBtn(locationSeq: widget.locationSeq),
              ],
            ),
          );
        },
      ),
    );
  }
}
