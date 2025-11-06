part of 'get_reports_cubit.dart';

@immutable
sealed class GetReportsState {}

final class GetReportsInitial extends GetReportsState {}

final class GetReportsLoading extends GetReportsState {}

final class GetReportsLoaded extends GetReportsState {
  final List<ReportEntity> reports;
  GetReportsLoaded(this.reports);
}

final class GetReportsError extends GetReportsState {
  final String message;
  GetReportsError(this.message);
}
