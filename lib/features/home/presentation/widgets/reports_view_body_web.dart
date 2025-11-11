import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../core/helpers/get_mock_report.dart';
import '../manager/cubits/get_report_cubit/get_reports_cubit.dart';
import '../views/report_details_view.dart';
import 'report_card.dart';

class ReportsViewBodyWeb extends StatelessWidget {
  const ReportsViewBodyWeb({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetReportsCubit, GetReportsState>(
      builder: (context, state) {
        if (state is GetReportsLoading) {
          return Skeletonizer(
            enabled: true,
            child: _buildGridView(
              reports: List.generate(6, (index) => getMockReport()),
              onTap: (report) {},
            ),
          );
        } else if (state is GetReportsError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(Icons.error_outline, size: 64, color: Colors.red[300]),
                const SizedBox(height: 16),
                Text(
                  state.message,
                  style: TextStyle(color: Colors.red[700], fontSize: 18),
                ),
              ],
            ),
          );
        } else if (state is GetReportsLoaded) {
          if (state.reports.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.inbox_outlined,
                    size: 100,
                    color: Colors.grey[300],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'لا توجد بلاغات',
                    style: TextStyle(fontSize: 24, color: Colors.grey[600]),
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'لم يتم إرسال أي بلاغات بعد',
                    style: TextStyle(fontSize: 16, color: Colors.grey[400]),
                  ),
                ],
              ),
            );
          }
          return _buildGridView(
            reports: state.reports,
            onTap: (report) {
              Navigator.pushNamed(
                context,
                ReportDetailsView.routeName,
                arguments: report,
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }

  Widget _buildGridView({
    required List reports,
    required Function(dynamic) onTap,
  }) {
    return LayoutBuilder(
      builder: (context, constraints) {
        // Calculate number of columns based on screen width
        int crossAxisCount = 1;
        if (constraints.maxWidth > 1400) {
          crossAxisCount = 3;
        } else if (constraints.maxWidth > 900) {
          crossAxisCount = 2;
        }

        return Center(
          child: Container(
            constraints: const BoxConstraints(maxWidth: 1600),
            padding: const EdgeInsets.all(24),
            child: GridView.builder(
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: crossAxisCount,
                childAspectRatio: 1.8,
                crossAxisSpacing: 24,
                mainAxisSpacing: 24,
              ),
              itemCount: reports.length,
              itemBuilder: (context, index) {
                final report = reports[index];
                return ReportCard(report: report, onTap: () => onTap(report));
              },
            ),
          ),
        );
      },
    );
  }
}
