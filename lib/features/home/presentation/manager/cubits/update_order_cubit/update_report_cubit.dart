import 'package:admin_dashboard/core/entities/report_entity.dart';
import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../../../../domain/repos/reports_repo.dart';

part 'update_report_state.dart';

class UpdateReportCubit extends Cubit<UpdateReportState> {
  final ReportsRepo reportsRepo;

  UpdateReportCubit(this.reportsRepo) : super(UpdateReportInitial());
  Future<void> updateReport(ReportEntity reportEntity) async {
    emit(UpdateReportLoading());
    final either = await reportsRepo.updateReport(reportEntity);
    either.fold(
      (failure) => emit(UpdateReportError(failure.message)),
      (_) => emit(UpdateReportSuccess(reportEntity)),
    );
  }
}
