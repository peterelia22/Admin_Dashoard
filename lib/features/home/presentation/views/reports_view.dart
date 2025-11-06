import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/services/get_it_service.dart';
import '../../domain/repos/reports_repo.dart';
import '../manager/cubits/get_report_cubit/get_reports_cubit.dart';
import '../widgets/reports_view_body.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});
  static const String routeName = '/reports';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          GetReportsCubit(getIt<ReportsRepo>())..fetchReports(),
      child: const Scaffold(body: ReportsViewBody()),
    );
  }
}
