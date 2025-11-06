import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../manager/cubits/get_report_cubit/get_reports_cubit.dart';
import 'report_card.dart';

class ReportsViewBody extends StatelessWidget {
  const ReportsViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetReportsCubit, GetReportsState>(
      builder: (context, state) {
        if (state is GetReportsLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is GetReportsError) {
          return Center(
            child: Text(
              state.message,
              style: const TextStyle(color: Colors.red),
            ),
          );
        } else if (state is GetReportsLoaded) {
          if (state.reports.isEmpty) {
            return const Center(child: Text('لا توجد بلاغات'));
          }
          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: state.reports.length,
            itemBuilder: (context, index) {
              final report = state.reports[index];
              return ReportCard(
                report: report,
                onTap: () {
                  // TODO: Navigate to report details
                  print('Tapped on report: ${report.reportId}');
                },
              );
            },
          );
        }
        return const SizedBox.shrink();
      },
    );
  }
}
