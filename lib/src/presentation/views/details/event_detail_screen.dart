import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/event_detail_view_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_top_app_bar.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_bottom_app_bar.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/event_header_card.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/section_header.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class EventDetailScreen extends StatefulWidget {
  final String eventId;
  const EventDetailScreen({Key? key, required this.eventId}) : super(key: key);

  @override
  State<EventDetailScreen> createState() => _EventDetailScreenState();
}

class _EventDetailScreenState extends State<EventDetailScreen> {
  int selectedTabIndex = 0;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<EventDetailViewModel>().fetchEventDetail();
    });
  }

  @override
  Widget build(BuildContext context) {
    final viewModel = context.watch<EventDetailViewModel>();

    return CustomScaffold(
      appBar: const CustomTopAppBar(isDark: true),
      body: Builder(
        builder: (context) {
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
                ShaderMask(
                  shaderCallback: (Rect bounds) {
                    return const LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: [0.0, 0.85, 1.0],
                      colors: [Colors.white, Colors.white, Colors.transparent],
                    ).createShader(bounds);
                  },
                  blendMode: BlendMode.dstIn,
                  child: Image.asset(
                    viewModel.event!.images.header,
                    fit: BoxFit.cover,
                    width: double.infinity,
                    height: 300,
                  ),
                ),
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
                        offset: const Offset(0, -50),
                        child: EventHeaderCard(
                          title: viewModel.event!.title,
                          description: viewModel.event!.description,
                          tags: viewModel.event!.tags,
                          selectedIndex: viewModel.selectedTabIndex,
                          onTabSelected: (index) {
                            viewModel.setSelectedTabIndex(index);
                          },
                        ),
                      ),
                      for (final section in viewModel.event!.sections) ...[
                        SectionHeader(text: section.header),
                        const SizedBox(height: 8),
                        Text(
                          section.body,
                          style: typography.AppTextStyle.bodyTextPoppins.copyWith(
                            fontSize: 16,
                            color:Colors.white,
                          ),
                        ),
                        const SizedBox(height: 24),
                      ],
                      Image.asset(viewModel.event!.images.bodyImage),
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
