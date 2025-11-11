import 'dart:developer';

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'core/helpers/on_generate_routes.dart';
import 'core/services/custom_bloc_observer.dart';
import 'core/services/get_it_service.dart';
import 'core/utils/shared_preferences_singleton.dart';
import 'features/auth/presentation/views/signin_view.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = CustomBlocObserver();

  try {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
    log('Firebase initialized');
  } on Exception catch (e) {
    log('Error initializing Firebase: $e');
  }
  await SharedPreferencesSingleton.init();
  setupGetit();

  runApp(const AdminDashboard());
}

class AdminDashboard extends StatelessWidget {
  const AdminDashboard({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      onGenerateRoute: onGenerateRoute,
      initialRoute: SigninView.routeName,
    );
  }
}
