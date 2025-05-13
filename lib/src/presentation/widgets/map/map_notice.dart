import 'package:flutter/material.dart';

import '../../../../l10n/app_localizations.dart';

class MapInfoBanner extends StatelessWidget {
  final int locationCount;

  const MapInfoBanner({super.key, required this.locationCount});

  @override
  Widget build(BuildContext context) {
    final noticeText = AppLocalizations.of(context)!.map_notice;

    return Container(
      margin: const EdgeInsets.only(top: 40, left: 20, right: 20),
      height: 80,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        image: const DecorationImage(
          image: AssetImage('assets/images/background.png'),
          fit: BoxFit.cover,
        ),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.3),
            blurRadius: 6,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Container(
        decoration: BoxDecoration(
          color: Colors.black.withOpacity(0.5),
          borderRadius: BorderRadius.circular(10),
        ),
        alignment: Alignment.center,
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: Text(
          noticeText,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 14,
            fontWeight: FontWeight.w500,
            height: 1.4,
          ),
          textAlign: TextAlign.center,
        ),
      ),
    );
  }
}
