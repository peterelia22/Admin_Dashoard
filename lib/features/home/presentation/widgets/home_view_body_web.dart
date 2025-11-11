import 'package:flutter/material.dart';

import '../../../../app_theme.dart';
import '../../../../core/widgets/custom_button.dart';
import '../views/reports_view.dart';

class HomeViewBodyWeb extends StatelessWidget {
  const HomeViewBodyWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppTheme.primaryColor.withOpacity(0.1),
            Colors.white,
            AppTheme.primaryColor.withOpacity(0.05),
          ],
        ),
      ),
      child: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 1200),
          padding: const EdgeInsets.all(40),
          child: Row(
            children: [
              // Left side - Dashboard info
              Expanded(
                flex: 5,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Admin Dashboard',
                      style: TextStyle(
                        fontSize: 48,
                        fontWeight: FontWeight.bold,
                        color: AppTheme.primaryColor,
                        height: 1.2,
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      'Manage and monitor all reports efficiently',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.grey[600],
                        height: 1.5,
                      ),
                    ),
                    const SizedBox(height: 40),
                    Row(
                      children: [
                        _buildStatCard(
                          icon: Icons.report,
                          title: 'Total Reports',
                          color: Colors.blue,
                        ),
                        const SizedBox(width: 20),
                        _buildStatCard(
                          icon: Icons.pending_actions,
                          title: 'Pending',
                          color: Colors.orange,
                        ),
                        const SizedBox(width: 20),
                        _buildStatCard(
                          icon: Icons.check_circle,
                          title: 'Completed',
                          color: Colors.green,
                        ),
                      ],
                    ),
                    const SizedBox(height: 40),
                    SizedBox(
                      width: 300,
                      height: 60,
                      child: CustomButton(
                        onPressed: () {
                          Navigator.pushNamed(context, ReportsView.routeName);
                        },
                        text: 'View All Reports',
                        gradientColors: AppTheme.primaryGradientColors,
                        shadowColor: AppTheme.primaryShadowColor,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(width: 60),
              // Right side - Illustration
              Expanded(
                flex: 4,
                child: Container(
                  padding: const EdgeInsets.all(40),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: AppTheme.primaryColor.withOpacity(0.1),
                        blurRadius: 30,
                        offset: const Offset(0, 10),
                      ),
                    ],
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.dashboard_customize_rounded,
                        size: 200,
                        color: AppTheme.primaryColor.withOpacity(0.7),
                      ),
                      const SizedBox(height: 20),
                      Text(
                        'Welcome Back!',
                        style: TextStyle(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: AppTheme.primaryColor,
                        ),
                      ),
                      const SizedBox(height: 12),
                      Text(
                        'Manage your reports with ease',
                        style: TextStyle(fontSize: 16, color: Colors.grey[600]),
                        textAlign: TextAlign.center,
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildStatCard({
    required IconData icon,
    required String title,
    required Color color,
  }) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(12),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.1),
              blurRadius: 10,
              offset: const Offset(0, 4),
            ),
          ],
        ),
        child: Column(
          children: [
            Icon(icon, size: 40, color: color),
            const SizedBox(height: 12),
            Text(
              title,
              style: TextStyle(
                fontSize: 14,
                color: Colors.grey[600],
                fontWeight: FontWeight.w500,
              ),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      ),
    );
  }
}
