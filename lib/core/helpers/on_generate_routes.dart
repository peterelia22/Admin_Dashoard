import 'package:flutter/material.dart';

import '../../features/auth/presentation/views/signin_view.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    default:
      return MaterialPageRoute(builder: (context) => const Scaffold());
  }
}
