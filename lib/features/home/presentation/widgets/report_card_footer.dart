import 'package:flutter/material.dart';

import '../../../../core/helpers/format_date_time.dart';

class ReportCardFooter extends StatelessWidget {
  final String? address;
  final DateTime createdAt;

  const ReportCardFooter({
    super.key,
    required this.address,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        if (address != null) ...[
          Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
          const SizedBox(width: 4),
          Expanded(
            child: Text(
              address!,
              style: TextStyle(fontSize: 12, color: Colors.grey[600]),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),
        ],
        const Spacer(),
        Icon(Icons.access_time, size: 16, color: Colors.grey[600]),
        const SizedBox(width: 4),
        Text(
          formatDateTime(createdAt),
          style: TextStyle(fontSize: 12, color: Colors.grey[600]),
        ),
      ],
    );
  }
}
