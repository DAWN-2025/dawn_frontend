import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/event_detail_view_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_top_app_bar.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_bottom_app_bar.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/header_card.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/section_header.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/image_header.dart';
import 'package:dawn_frontend/src/presentation/widgets/location/location_card_list.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class EventDetailScreen extends StatefulWidget {
  final String eventId;
  const EventDetailScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventDetailViewModel>().fetchEventDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomTopAppBar(isDark: true),
      body: Consumer<EventDetailViewModel>(
        builder: (context, viewModel, child) {
          print("Rebuilding UI with tab index: ${viewModel.selectedTabIndex}");  // 디버깅용

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

          return SingleChildScrollView(
            child: Column(
              children: [
                ImageHeader(imagePath: viewModel.event!.images.header),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Transform.translate(
                        offset: const Offset(0, -50),
                        child: HeaderCard(
                          title: viewModel.event!.title,
                          description: viewModel.event!.description,
                          tags: viewModel.event!.tags,
                          selectedIndex: viewModel.selectedTabIndex,
                          tabLabels: ["Details", "Locations"],
                          onTabSelected: (index) {
                            print("Tab selected: $index");  // 디버깅용
                            context.read<EventDetailViewModel>().setSelectedTabIndex(index);
                          },
                        ),
                      ),
                      if (viewModel.selectedTabIndex == 0) ...[
                        for (final section in viewModel.event!.sections) ...[
                          SectionHeader(text: section.header),
                          const SizedBox(height: 8),
                          Text(
                            section.body,
                            style: typography.AppTextStyle.bodyTextPoppins
                                .copyWith(fontSize: 16, color: Colors.white),
                          ),
                          const SizedBox(height: 24),
                        ],
                        Image.asset(viewModel.event!.images.bodyImage),
                      ] else if (viewModel.selectedTabIndex == 1) ...[
                        const SizedBox(height: 16),
                        Text(
                          "Locations",
                          style: typography.AppTextStyle.bodyTextPoppins
                              .copyWith(fontSize: 18, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        SizedBox(
                          height: 300,
                          child: LocationCardList(locations: viewModel.event!.locations),
                        ),
                      ],
                    ],
                  ),
                ),
              ],
            ),
          );
        },
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
