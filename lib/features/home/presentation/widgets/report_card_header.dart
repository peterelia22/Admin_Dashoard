import 'package:flutter/material.dart';

import '../../../../core/entities/report_entity.dart';
import 'status_chip.dart';

class ReportCardHeader extends StatelessWidget {
  final ReportEntity report;

  const ReportCardHeader({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Expanded(
          child: Text(
            report.title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ),
        const SizedBox(width: 8),
        StatusChip(
          status: report.status,
          displayName: report.statusDisplayName,
        ),
      ],
    );
  }
}
