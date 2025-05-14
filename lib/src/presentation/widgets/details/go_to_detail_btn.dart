import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:dawn_frontend/src/presentation/view_models/ai-tour/explore_now_btn_view_model.dart';
import 'package:go_router/go_router.dart';

class GoToDetailBtn extends StatelessWidget {
  final int locationSeq;
  const GoToDetailBtn({Key? key, required this.locationSeq}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 0, 20, 40),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(50),
        child: BackdropFilter(
          filter: ImageFilter.blur(sigmaX: 10, sigmaY: 10),
          child: GestureDetector(
            onTap: () {
              // Using Provider to call the view model method
              context.push('/location-detail/$locationSeq');
            },
            child: Container(
              width: double.infinity,
              height: 60,
              padding: const EdgeInsets.symmetric(vertical: 14),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white.withOpacity(0.3)),
                gradient: const LinearGradient(
                  colors: [
                    Color(0xff744ff9),
                    Color(0xff8369de),
                    Color(0xff8da0cb),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                color: Colors.grey.withOpacity(0.1),
                borderRadius: BorderRadius.circular(50),
                boxShadow: [
                  BoxShadow(
                    color: Colors.white.withOpacity(0.03),
                    blurRadius: 20,
                    offset: const Offset(0, 5),
                  ),
                ],
              ),
              child: Center(
                child: Text(
                  "Go to Detail",
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
