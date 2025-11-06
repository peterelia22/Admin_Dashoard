import 'package:intl/intl.dart';

String formatDateTime(DateTime dateTime) {
  final now = DateTime.now();
  final difference = now.difference(dateTime);
  final timeFormatter = DateFormat('hh:mm a');
  final dateFormatter = DateFormat('dd/MM/yyyy');

  final timeStr = timeFormatter.format(dateTime);
  final dateStr = dateFormatter.format(dateTime);

  if (difference.inMinutes < 1) {
    return '$timeStr • الآن';
  } else if (difference.inMinutes < 60) {
    return '$timeStr • منذ ${difference.inMinutes} دقيقة';
  } else if (difference.inHours < 24) {
    return '$timeStr • منذ ${difference.inHours} ساعة';
  } else if (difference.inDays < 7) {
    return '$timeStr $dateStr • منذ ${difference.inDays} يوم';
  } else {
    return '$timeStr • $dateStr';
  }
}
