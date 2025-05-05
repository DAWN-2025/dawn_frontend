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
            SafeArea(
              child: Align(
                alignment: Alignment.topCenter,
                child: Padding(
                  padding: const EdgeInsets.only(top: 40.0),
                  child: Text(
                    'Album',
                    style: typography.AppTextStyle.heading2.copyWith(
                      color: Colors.white,
                    ),
                  ),
                ),
              ),
            ),
            const SizedBox(height: 0),
            // 👇 GridView는 Expanded로 감싸서 아래 영역 채우게
            Expanded(
              child: FutureBuilder(
                future: _loadFuture,
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(child: CircularProgressIndicator());
                  }

                  if (stampCardListViewModel.stampCards.isEmpty) {
                    return const Center(
                      child: Text('No Stamp Cards Available'),
                    );
                  }

                  return GridView.builder(
                    padding: const EdgeInsets.only(top: 40.0),
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                          crossAxisCount: 2,
                          crossAxisSpacing: 20.0,
                          mainAxisSpacing: 25.0,
                          childAspectRatio: 155 / 180,
                        ),
                    itemCount: stampCardListViewModel.stampCards.length,
                    itemBuilder: (context, index) {
                      final viewModel =
                          stampCardListViewModel.stampCards[index];
                      return StampCard(viewModel: viewModel);
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
