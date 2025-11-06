import 'package:get_it/get_it.dart';

import '../../features/home/data/repos/reports_repo_impl.dart';
import '../../features/home/domain/repos/reports_repo.dart';
import 'database_service.dart';
import 'firestore_sevice.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<DatabaseService>(FireStoreService());
  getIt.registerSingleton<ReportsRepo>(
    ReportsRepoImpl(getIt<DatabaseService>()),
  );
}
