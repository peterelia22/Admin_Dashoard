import 'package:flutter/material.dart';

import '../enums/report_status_enums.dart';

Color getStatusColor(ReportStatusEnum status) {
  switch (status) {
    case ReportStatusEnum.pending:
      return Colors.orange;
    case ReportStatusEnum.inReview:
      return Colors.blue;
    case ReportStatusEnum.investigating:
      return Colors.purple;
    case ReportStatusEnum.resolved:
      return Colors.green;
    case ReportStatusEnum.rejected:
      return Colors.red;
  }
}
