import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/location_detail_view_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_top_app_bar.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_bottom_app_bar.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/header_card.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/section_header.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/image_header.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class LocationDetailScreen extends StatefulWidget {
  final int locationId;

  const LocationDetailScreen({Key? key, required this.locationId})
    : super(key: key);

  @override
  State<LocationDetailScreen> createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<LocationDetailViewModel>().fetchLocationDetail(
        widget.locationId,
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomTopAppBar(isDark: true),
      body: Consumer<LocationDetailViewModel>(
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

          if (viewModel.location == null) {
            return const Center(child: Text("No location details available"));
          }

          final location = viewModel.location!;

          return SingleChildScrollView(
            child: Column(
              children: [
                // 이미지 헤더
                ImageHeader(imagePath: location.image),
                Container(
                  width: double.infinity,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 30,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // HeaderCard 사용
                      Transform.translate(
                        offset: const Offset(0, -50),
                        child: HeaderCard(
                          title: location.name,
                          description: viewModel.formattedDescription,
                          tags: location.keywords,
                          selectedIndex: viewModel.selectedTabIndex,
                          tabLabels: ["Info", "Comments"],
                          onTabSelected: (index) {
                            context
                                .read<LocationDetailViewModel>()
                                .setSelectedTabIndex(index);
                          },
                        ),
                      ),
                      const SizedBox(height: 16),

                      if (viewModel.selectedTabIndex == 0) ...[
                        // 기본 정보 섹션
                        SectionHeader(text: "Location Information"),
                        const SizedBox(height: 8),
                        Text(
                          location.address,
                          style: typography.AppTextStyle.bodyTextPoppins
                              .copyWith(fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(height: 16),

                        // 세부 정보 섹션
                        SectionHeader(text: "Details"),
                        const SizedBox(height: 8),
                        Text(
                          "History: ${location.historicInfo}",
                          style: typography.AppTextStyle.bodyTextPoppins
                              .copyWith(fontSize: 16, color: Colors.white),
                        ),
                        const SizedBox(height: 8),
                        Text(
                          "Etiquette: ${location.etiquette}",
                          style: typography.AppTextStyle.bodyTextPoppins
                              .copyWith(fontSize: 16, color: Colors.white),
                        ),
                      ] else if (viewModel.selectedTabIndex == 1) ...[
                        //CommentList(
                        //  ...,
                        //),
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
