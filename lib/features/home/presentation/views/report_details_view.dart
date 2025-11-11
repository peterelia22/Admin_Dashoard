import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_theme.dart';
import '../../../../core/entities/report_entity.dart';
import '../../../../core/services/get_it_service.dart';
import '../../../home/domain/repos/reports_repo.dart';
import '../manager/cubits/update_reports_cubit/update_report_cubit.dart';
import '../widgets/reports_details_view_body.dart';
import '../widgets/reports_details_view_body_web.dart';

class ReportDetailsView extends StatelessWidget {
  static const String routeName = '/report-details';
  final ReportEntity report;

  const ReportDetailsView({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdateReportCubit(getIt<ReportsRepo>()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          title: const Text(
            'تفاصيل البلاغ',
            style: TextStyle(color: Colors.white),
          ),
          centerTitle: true,
          elevation: kIsWeb ? 2 : 0,
        ),
        body: kIsWeb
            ? ReportsDetailsViewBodyWeb(report: report)
            : ReportsDetailsViewBody(report: report),
      ),
    );
  }
}
