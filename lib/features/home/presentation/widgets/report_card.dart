import 'package:flutter/material.dart';

import '../../../../core/entities/report_entity.dart';
import 'report_card_footer.dart';
import 'report_card_header.dart';
import 'report_media_preview.dart';

class ReportCard extends StatelessWidget {
  final ReportEntity report;
  final VoidCallback? onTap;

  const ReportCard({super.key, required this.report, this.onTap});

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 12),
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(12),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ReportCardHeader(report: report),
              const SizedBox(height: 8),
              Text(
                report.description,
                style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                maxLines: 2,
                overflow: TextOverflow.ellipsis,
              ),
              const SizedBox(height: 12),
              if (report.mediaUrls.isNotEmpty) ...[
                ReportMediaPreview(mediaUrls: report.mediaUrls),
                const SizedBox(height: 12),
              ],
              ReportCardFooter(
                address: report.address,
                createdAt: report.createdAt,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
