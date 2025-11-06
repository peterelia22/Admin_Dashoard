import 'package:admin_dashboard/features/home/presentation/views/reports_view.dart';
import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/signin_view.dart';
import '../../features/home/presentation/views/home_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SigninView.routeName:
      return MaterialPageRoute(builder: (context) => const SigninView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => const HomeView());
    case ReportsView.routeName:
      return MaterialPageRoute(builder: (context) => const ReportsView());
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
