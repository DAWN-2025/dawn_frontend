import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/event_detail_view_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_top_app_bar.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_bottom_app_bar.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/header_card.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/section_header.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/image_header.dart';
import 'package:dawn_frontend/src/presentation/widgets/location_card_list.dart';
import 'package:dawn_frontend/src/presentation/view_models/location_card_view_model.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class EventDetailScreen extends StatefulWidget {
  final int eventId;
  final int userSeq;

  const EventDetailScreen({Key? key, required this.eventId, required this.userSeq}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  void initState() {
    super.initState();
    print('Received event ID on detail event page: ${widget.eventId}');
    WidgetsBinding.instance.addPostFrameCallback((_) async {
    final eventId = widget.eventId;

    // EventDetail 가져오기
    context.read<EventDetailViewModel>().fetchEventDetail(eventId);

    // Location 정보 초기화 및 로드
    //context.read<LocationCardViewModel>().clearLocations();
    context.read<LocationCardViewModel>().fetchEventLocations(eventId);
  });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomTopAppBar(isDark: true),
      body: Consumer<EventDetailViewModel>(
        builder: (context, viewModel, child) {
          if (viewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (viewModel.errorMessage != null) {
            return Center(
              child: Text(
                viewModel.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (viewModel.event == null) {
            return const Center(child: Text("No event details available"));
          }

          final event = viewModel.event!;

          return Padding(
            padding: const EdgeInsets.only(
              bottom: kBottomNavigationBarHeight + 50, // 하단 패딩 추가
            ),
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ImageHeader(imagePath: event.image),
                  Container(
                    width: double.infinity,
                    padding: const EdgeInsets.symmetric(
                      horizontal: 20,
                      vertical: 30,
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Transform.translate(
                          offset: const Offset(0, -70),
                          child: HeaderCard(
                            title: event.name,
                            description: event.shortInfo,
                            tags: event.keywords,
                            selectedIndex: viewModel.selectedTabIndex,
                            tabLabels: ["Info", "Locations"],
                            onTabSelected: (index) {
                              context
                                  .read<EventDetailViewModel>()
                                  .setSelectedTabIndex(index);
                            },
                          ),
                        ),
                        if (viewModel.selectedTabIndex == 0) ...[
                          SectionHeader(text: "Background"),
                          const SizedBox(height: 8),
                          Text(
                            event.background,
                            style: typography.AppTextStyle.bodyTextPoppins
                                .copyWith(fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(height: 24),
                          SectionHeader(text: "Progress"),
                          const SizedBox(height: 8),
                          Text(
                            event.progress,
                            style: typography.AppTextStyle.bodyTextPoppins
                                .copyWith(fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(height: 24),
                          SectionHeader(text: "Meaning"),
                          const SizedBox(height: 8),
                          Text(
                            event.meaning,
                            style: typography.AppTextStyle.bodyTextPoppins
                                .copyWith(fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(height: 24),
                          Image.network(event.image),
                        ] else if (viewModel.selectedTabIndex == 1) ...[
                          LocationCardList(
                            locationCards: context
                                .watch<LocationCardViewModel>()
                                .locationCards,
                          ),
                        ],
                      ],
                    ),
                  ),
                ],
              ),
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
