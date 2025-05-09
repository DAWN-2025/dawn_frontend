import 'package:dawn_frontend/src/core/theme/typography.dart';
import 'package:dawn_frontend/src/presentation/view_models/home/event_cards_view_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/home/weekly_featured_view_model.dart';
import 'package:dawn_frontend/src/presentation/view_models/language_view_model.dart';
import 'package:dawn_frontend/src/presentation/widgets/home/event_card.dart';
import 'package:dawn_frontend/src/presentation/widgets/home/search_input_field.dart';
import 'package:dawn_frontend/src/presentation/widgets/home/weekly_featured_card.dart';
import 'package:flutter/material.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_scaffold.dart';
import 'package:dawn_frontend/src/presentation/widgets/custom_bottom_app_bar.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

import '../../../../l10n/app_localizations.dart';
import '../../../core/utils/date_utils.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<WeeklyFeaturedViewModel>().loadWeeklyEvent();
      context.read<EventCardsViewModel>().loadEvents(context);
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomScaffold(
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            const SizedBox(height: 115),
            Center(
              child: SvgPicture.asset(
                'assets/icons/logo_sub.svg',
                width: 215,
                height: 44,
              ),
            ),
            const SizedBox(height: 20),

            // 1. 검색바 - Padding 추가
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: SearchInputField(
                controller: _searchController,
                hintText: null,
              ),
            ),

            const SizedBox(height: 20),

            // 2. 날짜 텍스트
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                getLocalizedWeekText(context, DateTime.now()),
                style: AppTextStyle.bodyText.copyWith(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // 3. 주간 추천 카드 - Padding 추가
            Consumer2<WeeklyFeaturedViewModel, LanguageViewModel>(
              builder: (context, weeklyVm, langVm, _) {
                final episode = weeklyVm.weekly;

                if (episode == null) {
                  return const Center(child: CircularProgressIndicator());
                }
                final locale = langVm.currentLocale.languageCode;

                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 30),
                  child: WeeklyFeaturedCard(
                    imageUrl: episode.eventImage,
                    title: episode.getNameByLocale(locale),
                    tags: episode.getKeywordsByLocale(locale),
                  ),
                );
              },
            ),

            const SizedBox(height: 14),

            // 4. 이벤트 텍스트
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Text(
                AppLocalizations.of(context)!.event,
                style: AppTextStyle.bodyText.copyWith(
                  fontSize: 20,
                  color: Colors.white,
                ),
              ),
            ),

            const SizedBox(height: 8),

            // 5. 이벤트 카드 리스트
            Consumer2<EventCardsViewModel, LanguageViewModel>(
              builder: (context, eventVm, langVm, _) {
                final locale = langVm.currentLocale.languageCode;

                if (eventVm.events.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                return SizedBox(
                  height: 195,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    padding: const EdgeInsets.symmetric(horizontal: 20),
                    child: Row(
                      children: eventVm.events.map((event) {
                        return EventCard(
                          imageUrl: event.eventImage,
                          title: event.getNameByLocale(locale),
                          tags: event.getKeywordsByLocale(locale),
                        );
                      }).toList(),
                    ),
                  ),
                );
              },
            ),
          ],
        ),
      ),
      bottomNavigationBar: const CustomBottomAppBar(),
    );
  }
}
