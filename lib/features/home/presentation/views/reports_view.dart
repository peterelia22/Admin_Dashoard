import 'package:flutter/material.dart';

import '../widgets/reports_view_body.dart';

class ReportsView extends StatelessWidget {
  const ReportsView({super.key});
  static const String routeName = '/reports';

  @override
  Widget build(BuildContext context) {
    return const Scaffold(body: ReportsViewBody());
  }
}
