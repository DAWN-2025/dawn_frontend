import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import '../../../l10n/app_localizations.dart';

/// 예: "Second week of April" / "4월 둘째 주"
String getLocalizedWeekText(BuildContext context, DateTime date) {
  final weekIndex = ((date.day - 1) / 7).floor() + 1;
  final localizations = AppLocalizations.of(context)!;

  // 1. 주차 텍스트 로컬라이징
  final weekText = {
    1: localizations.week_1,
    2: localizations.week_2,
    3: localizations.week_3,
    4: localizations.week_4,
    5: localizations.week_5,
  }[weekIndex]!;

  // 2. 월 텍스트 (언어별로 다르게)
  final locale = Localizations.localeOf(context).languageCode;

  if (locale == 'ko') {
    // 한국어 → "4월 둘째 주"
    return '${date.month}월 $weekText';
  } else {
    // 영어 → "Second week of April"
    final monthText = DateFormat.MMMM(locale).format(date); // "April"
    return '$weekText of $monthText';
  }
}
