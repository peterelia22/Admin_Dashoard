import 'package:cloud_firestore/cloud_firestore.dart';

import '../enums/report_status_enums.dart';
import '../helpers/status_to_and_from_string.dart';

class ReportNotificationModel {
  final String id;
  final String reportId;
  final String title;
  final String message;
  final ReportStatusEnum status;
  final DateTime timestamp;
  final bool isRead;

  const ReportNotificationModel({
    required this.id,
    required this.reportId,
    required this.title,
    required this.message,
    required this.status,
    required this.timestamp,
    this.isRead = false,
  });

  factory ReportNotificationModel.fromJson(Map<String, dynamic> json) {
    return ReportNotificationModel(
      id: json['id'] ?? '',
      reportId: json['reportId'] ?? '',
      title: json['title'] ?? '',
      message: json['message'] ?? '',
      status: statusFromString(json['status']),
      timestamp: json['timestamp'] is Timestamp
          ? (json['timestamp'] as Timestamp).toDate()
          : DateTime.parse(json['timestamp']),
      isRead: json['isRead'] ?? false,
    );
  }

  // Convert model to JSON (for Firestore)
  Map<String, dynamic> toJson() {
    return {
      'reportId': reportId,
      'title': title,
      'message': message,
      'status': statusToString(status),
      'timestamp': Timestamp.fromDate(timestamp),
      'isRead': isRead,
    };
  }

  // Create a copy with updated fields
  ReportNotificationModel copyWith({
    String? id,
    String? reportId,
    String? title,
    String? message,
    ReportStatusEnum? status,
    DateTime? timestamp,
    bool? isRead,
  }) {
    return ReportNotificationModel(
      id: id ?? this.id,
      reportId: reportId ?? this.reportId,
      title: title ?? this.title,
      message: message ?? this.message,
      status: status ?? this.status,
      timestamp: timestamp ?? this.timestamp,
      isRead: isRead ?? this.isRead,
    );
  }
}
