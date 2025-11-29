import 'package:aman24_admin/core/widgets/custom_button.dart';
import 'package:flutter/material.dart';

import '../../../../app_theme.dart';
import '../views/reports_view.dart';

class HomeViewBody extends StatelessWidget {
  const HomeViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: Center(
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CustomButton(
                onPressed: () {
                  Navigator.pushNamed(context, ReportsView.routeName);
                },
                text: 'عرض البلاغات',
                gradientColors: AppTheme.primaryGradientColors,
                shadowColor: AppTheme.primaryShadowColor,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
