import 'package:flutter/material.dart';

import 'media_thumbnail.dart';

class ReportMediaPreview extends StatelessWidget {
  final List<String> mediaUrls;

  const ReportMediaPreview({super.key, required this.mediaUrls});

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 100,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: mediaUrls.length > 4 ? 4 : mediaUrls.length,
        itemBuilder: (context, index) {
          final mediaUrl = mediaUrls[index];
          final showMoreIndicator = index == 3 && mediaUrls.length > 4;
          final remainingCount = mediaUrls.length - 4;

          return MediaThumbnail(
            mediaUrl: mediaUrl,
            showMoreIndicator: showMoreIndicator,
            remainingCount: remainingCount,
          );
        },
      ),
    );
  }
}
