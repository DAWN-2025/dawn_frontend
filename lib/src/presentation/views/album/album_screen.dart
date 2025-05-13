import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_bottom_app_bar.dart';
import '../../widgets/stamp_card.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/stamp_card_list_view_model.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;
import 'package:go_router/go_router.dart';

class AlbumScreen extends StatefulWidget {
  const AlbumScreen({super.key});

  @override
  State<AlbumScreen> createState() => _AlbumScreenState();
}

class _AlbumScreenState extends State<AlbumScreen> {
  late Future<void> _loadFuture;

  @override
  void initState() {
    super.initState();
    final stampCardListViewModel = Provider.of<StampCardListViewModel>(
      context,
      listen: false,
    );
    _loadFuture = stampCardListViewModel.loadStampCards();
  }

  @override
Widget build(BuildContext context) {
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
              future: _loadFuture,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (stampCardListViewModel.stampCards.isEmpty) {
                  return Center(
                    child: Text(stampCardListViewModel.errorMessage),
                  );
                }

                return GridView.builder(
                  padding: const EdgeInsets.only(top: 10.0),  // 적절한 간격 조정
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    crossAxisSpacing: 20.0,
                    mainAxisSpacing: 25.0,
                    childAspectRatio: 0.9,
                  ),
                  itemCount: stampCardListViewModel.stampCards.length,
                  itemBuilder: (context, index) {
                      final stamp = stampCardListViewModel.stampCards[index];
                      return StampCard(
                        title: stamp.eventName,         // 이벤트 이름
                        imagePath: stamp.eventStampImg, // 스탬프 이미지
                        onTap: () {
                          context.push('/event/detail/${stamp.eventSeq}');
                        },
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
