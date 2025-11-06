import 'package:flutter/material.dart';

import '../../../../core/enums/report_status_enums.dart';
import '../../../../core/helpers/report_status_helper.dart';

class StatusChip extends StatelessWidget {
  final ReportStatusEnum status;
  final String displayName;

  const StatusChip({
    super.key,
    required this.status,
    required this.displayName,
  });

  @override
  Widget build(BuildContext context) {
    final color = getStatusColor(status);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: BoxDecoration(
        color: color.withOpacity(0.1),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color, width: 1),
      ),
      child: Text(
        displayName,
        style: TextStyle(
          color: color,
          fontSize: 12,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
