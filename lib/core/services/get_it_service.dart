import 'package:get_it/get_it.dart';

import 'database_service.dart';
import 'firebase_auth_service.dart';
import 'firestore_sevice.dart';
import 'storage_service.dart';

final getIt = GetIt.instance;

void setupGetit() {
  getIt.registerSingleton<DatabaseService>(FireStoreService());
}
