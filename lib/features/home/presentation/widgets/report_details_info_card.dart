import 'package:flutter/material.dart';

import '../../../../core/entities/report_entity.dart';
import '../../../../core/helpers/format_date_time.dart';
import 'info_row_widget.dart';
import 'section_title_widget.dart';

class ReportDetailsInfoCard extends StatelessWidget {
  final ReportEntity report;

  const ReportDetailsInfoCard({super.key, required this.report});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SectionTitleWidget(title: 'الوصف', icon: Icons.description),
            const SizedBox(height: 12),
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.grey[50],
                borderRadius: BorderRadius.circular(12),
                border: Border.all(color: Colors.grey[200]!),
              ),
              child: Text(
                report.description,
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey[800],
                  height: 1.5,
                ),
              ),
            ),
            const SizedBox(height: 20),
            const SectionTitleWidget(title: 'الموقع', icon: Icons.location_on),
            const SizedBox(height: 12),
            if (report.address != null)
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Row(
                  children: [
                    Icon(Icons.place, color: Colors.red[400], size: 20),
                    const SizedBox(width: 8),
                    Expanded(
                      child: Text(
                        report.address!,
                        style: TextStyle(fontSize: 14, color: Colors.grey[800]),
                      ),
                    ),
                  ],
                ),
              )
            else
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[50],
                  borderRadius: BorderRadius.circular(12),
                  border: Border.all(color: Colors.grey[200]!),
                ),
                child: Text(
                  'لم يتم تحديد الموقع',
                  style: TextStyle(
                    fontSize: 14,
                    color: Colors.grey[500],
                    fontStyle: FontStyle.italic,
                  ),
                ),
              ),
            const SizedBox(height: 20),
            const SectionTitleWidget(
              title: 'معلومات إضافية',
              icon: Icons.info_outline,
            ),
            const SizedBox(height: 12),
            InfoRowWidget(
              label: 'Report ID',
              value: report.reportId,
              icon: Icons.tag,
            ),
            const SizedBox(height: 8),
            InfoRowWidget(
              label: 'تاريخ التحديث',
              value: formatDateForDetails(report.updatedAt),
              icon: Icons.update,
            ),
          ],
        ),
      ),
    );
  }
}
