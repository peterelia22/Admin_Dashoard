import 'package:admin_dashboard/core/entities/report_entity.dart';
import 'package:admin_dashboard/core/errors/failures.dart';
import 'package:admin_dashboard/core/models/report_model.dart';
import 'package:admin_dashboard/core/models/report_notification_model.dart';
import 'package:admin_dashboard/features/home/domain/repos/reports_repo.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/services/database_service.dart';
import '../../../../core/utils/backend_endpoint.dart';

class ReportsRepoImpl implements ReportsRepo {
  final DatabaseService databaseService;

  ReportsRepoImpl(this.databaseService);

  @override
  Stream<Either<Failure, List<ReportEntity>>> streamReports() async* {
    try {
      await for (var data in databaseService.streamCollection(
        path: BackendEndpoint.getReports,
      )) {
        List<ReportEntity> reports = (data as List<dynamic>)
            .map<ReportEntity>((e) => ReportModel.fromJson(e).toEntity())
            .toList();
        yield Right(reports);
      }
    } catch (e) {
      yield Left(ServerFailure('Failed to stream reports: $e'));
    }
  }

  @override
  Future<Either<Failure, void>> updateReport(ReportEntity reportEntity) async {
    try {
      await databaseService.updateData(
        data: {
          'status': reportEntity.status.name,
          'updatedAt': reportEntity.updatedAt.toIso8601String(),
          if (reportEntity.adminComment != null)
            'adminComment': reportEntity.adminComment,
        },
        path: BackendEndpoint.updateReportStatus,
        documentId: reportEntity.reportId,
      );

      await databaseService.addData(
        path: BackendEndpoint.addNotifications,
        data: ReportNotificationModel.fromEntity(reportEntity).toJson(),
      );

      return right(null);
    } catch (e) {
      return Left(ServerFailure('Failed to update report: $e'));
    }
  }
}
