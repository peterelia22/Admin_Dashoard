part of 'update_report_cubit.dart';

@immutable
sealed class UpdateReportState {}

final class UpdateReportInitial extends UpdateReportState {}

final class UpdateReportLoading extends UpdateReportState {}

final class UpdateReportSuccess extends UpdateReportState {
  final ReportEntity reportEntity;

  UpdateReportSuccess(this.reportEntity);
}

final class UpdateReportError extends UpdateReportState {
  final String message;

  UpdateReportError(this.message);
}
