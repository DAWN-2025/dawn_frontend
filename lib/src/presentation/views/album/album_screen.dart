import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_bottom_app_bar.dart';
import '../../widgets/stamp_card.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/stamp_card_list_view_model.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late Future<void> _loadDataFuture;

  @override
  void initState() {
    super.initState();
    _loadDataFuture = _loadData();
  }

  Future<void> _loadData() async {
    await Provider.of<StampCardListViewModel>(context, listen: false).loadStampCards();
  }

  @override
  Widget build(BuildContext context) {
    // 변경점: Provider를 직접 사용하여 상태 관리
    final stampCardListViewModel = Provider.of<StampCardListViewModel>(context);

    return CustomScaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            // 상단 여백 조정
            const SizedBox(height: kToolbarHeight + 50),
            Align(
              alignment: Alignment.topCenter,
              child: Text(
                'Album',
                style: typography.AppTextStyle.heading2.copyWith(
                  color: Colors.white,
                ),
              ),
            ),
            // Album과 리스트 사이 간격 조정
            const SizedBox(height: 30),
            Expanded(
              child: FutureBuilder(
                future: _loadDataFuture,
                builder: (context, snapshot) {
                  // 로딩 중일 때 표시
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  // 에러가 있을 때 표시
                  if (stampCardListViewModel.errorMessage.isNotEmpty) {
                    return Center(
                      child: Text(
                        stampCardListViewModel.errorMessage,
                        style: const TextStyle(color: Colors.red),
                      ),
                    );
                  }

                  // 스탬프 카드 목록이 비었을 때 표시
                  if (stampCardListViewModel.stampCards.isEmpty) {
                    return const Center(child: Text('No stamps available'));
                  }

                  // 스탬프 카드 목록이 있을 때 표시
                  return GridView.builder(
                    padding: const EdgeInsets.only(top: 10.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 25.0,
                          childAspectRatio: 0.9,
                        ),
                    itemCount: stampCardListViewModel.stampCards.length,
                    itemBuilder: (context, index) {
                      final stamp = stampCardListViewModel.stampCards[index];
                      return StampCard(
                        title: stamp.eventNameEng, // 이벤트 이름
                        imagePath: stamp.eventStampImg, // 스탬프 이미지
                        eventId: stamp.eventId,
                        isVisited: stamp.isVisited ?? false, // 방문 여부
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomAppBar(),
    );
  }
}
