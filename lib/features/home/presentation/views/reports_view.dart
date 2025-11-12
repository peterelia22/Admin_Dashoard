import 'package:flutter/foundation.dart' show kIsWeb;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../app_theme.dart';
import '../../../../core/services/get_it_service.dart';
import '../../domain/repos/reports_repo.dart';
import '../manager/cubits/get_report_cubit/get_reports_cubit.dart';
import '../widgets/reports_view_body.dart';
import '../widgets/reports_view_body_web.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});
  static const String routeName = '/reports';
  // reports view
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetReportsCubit(getIt<ReportsRepo>())..fetchReports(),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: AppTheme.primaryColor,
          title: const Text('البلاغات', style: TextStyle(color: Colors.white)),
          centerTitle: true,
          // Add elevation for web
          elevation: kIsWeb ? 2 : 0,
        ),
        body: kIsWeb ? const ReportsViewBodyWeb() : const ReportsViewBody(),
      ),
    );
  }
}
