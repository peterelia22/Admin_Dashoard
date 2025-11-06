import '../entities/report_entity.dart';
import '../enums/report_status_enums.dart';

ReportEntity getMockReport() {
  return ReportEntity(
    reportId: 'loading-id',
    userId: 'loading-user',
    title: 'Loading Report Title Here',
    description:
        'This is a placeholder description for the loading state that will be replaced with actual content',
    mediaUrls: [
      'https://via.placeholder.com/150',
      'https://via.placeholder.com/150',
    ],
    address: 'Loading Address, Loading City',
    status: ReportStatusEnum.pending,
    createdAt: DateTime.now(),
    updatedAt: DateTime.now(),
  );
}
