import 'package:flutter/material.dart';

import '../../../../app_theme.dart';
import '../../../../core/enums/report_status_enums.dart';
import '../../../../core/helpers/report_status_helper.dart';

class UpdateStatusSection extends StatelessWidget {
  final ReportStatusEnum currentStatus;
  final ReportStatusEnum? selectedStatus;
  final ValueChanged<ReportStatusEnum?> onStatusChanged;

  const UpdateStatusSection({
    super.key,
    required this.currentStatus,
    required this.selectedStatus,
    required this.onStatusChanged,
  });

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
            Row(
              children: [
                Icon(Icons.update, size: 22, color: AppTheme.primaryColor),
                const SizedBox(width: 8),
                Text(
                  'تحديث حالة البلاغ',
                  style: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                    color: Colors.grey[800],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Container(
              padding: const EdgeInsets.all(12),
              decoration: BoxDecoration(
                color: AppTheme.primaryColor.withOpacity(0.1),
                borderRadius: BorderRadius.circular(12),
                border: Border.all(
                  color: AppTheme.primaryColor.withOpacity(0.3),
                ),
              ),
              child: Row(
                children: [
                  Icon(
                    Icons.info_outline,
                    size: 18,
                    color: AppTheme.primaryColor,
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      'اختر الحالة الجديدة للبلاغ',
                      style: TextStyle(
                        fontSize: 13,
                        color: AppTheme.primaryColor.withOpacity(0.9),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),
            Wrap(
              spacing: 12,
              runSpacing: 12,
              children: ReportStatusEnum.values
                  .where((status) => status != ReportStatusEnum.pending)
                  .map((status) {
                    final isSelected = selectedStatus == status;
                    final statusColor = getStatusColor(status);
                    final statusName = _getStatusDisplayName(status);

                    return GestureDetector(
                      onTap: () => onStatusChanged(status),
                      child: AnimatedContainer(
                        duration: const Duration(milliseconds: 200),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 16,
                          vertical: 12,
                        ),
                        decoration: BoxDecoration(
                          color: isSelected
                              ? statusColor
                              : statusColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: statusColor,
                            width: isSelected ? 2 : 1,
                          ),
                          boxShadow: isSelected
                              ? [
                                  BoxShadow(
                                    color: statusColor.withOpacity(0.3),
                                    blurRadius: 8,
                                    offset: const Offset(0, 3),
                                  ),
                                ]
                              : [],
                        ),
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            Icon(
                              _getStatusIcon(status),
                              color: isSelected ? Colors.white : statusColor,
                              size: 18,
                            ),
                            const SizedBox(width: 8),
                            Text(
                              statusName,
                              style: TextStyle(
                                color: isSelected ? Colors.white : statusColor,
                                fontSize: 14,
                                fontWeight: isSelected
                                    ? FontWeight.bold
                                    : FontWeight.w600,
                              ),
                            ),
                            if (isSelected) ...[
                              const SizedBox(width: 8),
                              const Icon(
                                Icons.check_circle,
                                color: Colors.white,
                                size: 18,
                              ),
                            ],
                          ],
                        ),
                      ),
                    );
                  })
                  .toList(),
            ),
          ],
        ),
      ),
    );
  }

  String _getStatusDisplayName(ReportStatusEnum status) {
    switch (status) {
      case ReportStatusEnum.pending:
        return 'قيد المراجعة';
      case ReportStatusEnum.inReview:
        return 'تحت المراجعة';
      case ReportStatusEnum.investigating:
        return 'جاري التحقيق';
      case ReportStatusEnum.resolved:
        return 'تم الحل';
      case ReportStatusEnum.rejected:
        return 'مرفوض';
    }
  }

  IconData _getStatusIcon(ReportStatusEnum status) {
    switch (status) {
      case ReportStatusEnum.pending:
        return Icons.access_time;
      case ReportStatusEnum.inReview:
        return Icons.visibility;
      case ReportStatusEnum.investigating:
        return Icons.search;
      case ReportStatusEnum.resolved:
        return Icons.check_circle;
      case ReportStatusEnum.rejected:
        return Icons.cancel;
    }
  }
}
