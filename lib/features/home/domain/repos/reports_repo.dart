import 'package:admin_dashboard/core/entities/report_entity.dart';
import 'package:dartz/dartz.dart';

import '../../../../core/errors/failures.dart';

abstract class ReportsRepo {
  Stream<Either<Failure, List<ReportEntity>>> streamReports();
  Future<Either<Failure, void>> updateReport(ReportEntity reportEntity);
}
