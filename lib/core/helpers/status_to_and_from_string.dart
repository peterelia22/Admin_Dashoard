import '../enums/report_status_enums.dart';

ReportStatusEnum statusFromString(String? statusString) {
  if (statusString == null) return ReportStatusEnum.pending;

  try {
    return ReportStatusEnum.values.firstWhere(
      (e) => e.name == statusString,
      orElse: () => ReportStatusEnum.pending,
    );
  } catch (e) {
    return ReportStatusEnum.pending;
  }
}

// Helper method to convert enum to string
String statusToString(ReportStatusEnum status) {
  switch (status) {
    case ReportStatusEnum.pending:
      return 'pending';
    case ReportStatusEnum.inReview:
      return 'inReview';
    case ReportStatusEnum.investigating:
      return 'investigating';
    case ReportStatusEnum.resolved:
      return 'resolved';
    case ReportStatusEnum.rejected:
      return 'rejected';
  }
}
