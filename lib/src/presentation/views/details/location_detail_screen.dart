import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/location_detail_view_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/details/comment_view_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_top_app_bar.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/header_card.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/section_header.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/image_header.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/comment_input_field.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/comment_card_list.dart';
import 'package:dawn_frontend/src/presentation/widgets/details/explore_now_btn.dart';
import 'package:dawn_frontend/src/core/theme/typography.dart' as typography;

class LocationDetailScreen extends StatefulWidget {
  final int locationId;

  const LocationDetailScreen({Key? key, required this.locationId}) : super(key: key);

  @override
  State<LocationDetailScreen> createState() => _LocationDetailScreenState();
}

class _LocationDetailScreenState extends State<LocationDetailScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Location 정보 로딩
      context.read<LocationDetailViewModel>().fetchLocationDetail(widget.locationId);
      // Comment 정보 로딩
      context.read<CommentViewModel>().fetchComments();  // 수정 부분
    });
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      appBar: const CustomTopAppBar(isDark: true),
      body: Consumer2<LocationDetailViewModel, CommentViewModel>(
        builder: (context, locationViewModel, commentViewModel, child) {
          if (locationViewModel.isLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (locationViewModel.errorMessage != null) {
            return Center(
              child: Text(
                locationViewModel.errorMessage!,
                style: const TextStyle(color: Colors.red),
              ),
            );
          }

          if (locationViewModel.location == null) {
            return const Center(child: Text("No location details available"));
          }

          final location = locationViewModel.location!;

          return Stack(
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    // 이미지 헤더
                    ImageHeader(imagePath: location.image),
                    Container(
                      width: double.infinity,
                      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          // HeaderCard 사용
                          Transform.translate(
                            offset: const Offset(0, -50),
                            child: HeaderCard(
                              title: location.name,
                              description: locationViewModel.formattedDescription,
                              tags: location.keywords,
                              selectedIndex: locationViewModel.selectedTabIndex,
                              tabLabels: ["Info", "Comments"],
                              onTabSelected: (index) {
                                locationViewModel.setSelectedTabIndex(index);
                              },
                            ),
                          ),
                          // const SizedBox(height: 16),

                          if (locationViewModel.selectedTabIndex == 0) ...[
                            SectionHeader(text: "Short Info"),
                            const SizedBox(height: 8),
                            Text(
                              location.shortInfo,
                              style: typography.AppTextStyle.bodyTextPoppins.copyWith(fontSize: 16, color: Colors.white),
                            ),
                            const SizedBox(height: 24),
                            SectionHeader(text: "Historical Info"),
                            const SizedBox(height: 8),
                            Text(
                              location.historicInfo,
                              style: typography.AppTextStyle.bodyTextPoppins.copyWith(fontSize: 16, color: Colors.white),
                            ),
                            const SizedBox(height: 24),
                            SectionHeader(text: "Etiquette"),
                            const SizedBox(height: 8),
                            Text(
                              location.etiquette,
                              style: typography.AppTextStyle.bodyTextPoppins.copyWith(fontSize: 16, color: Colors.white),
                            ),
                          ] else if (locationViewModel.selectedTabIndex == 1) ...[
                            if (commentViewModel.comments.isEmpty)
                              const Text(
                                "No comments available",
                                style: TextStyle(color: Colors.grey),
                              )
                            else
                              CommentCardList()  
                          ],
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              if (locationViewModel.selectedTabIndex == 0) ...[
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: ExploreNowBtn(
                    onTap: () {
                      print("Explore Now button tapped");
                      // Add your onTap logic here
                    },
                  ),
                ),
              ] else if (locationViewModel.selectedTabIndex == 1) ...[
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: CommentInputField(
                    onSubmit: (text) {
                      context.read<CommentViewModel>().addComment(text);
                    },
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
