import 'package:flutter/material.dart';

class ShowSnackBar {
  static void showSnackBar(
      BuildContext context, String message, String musicName) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          children: [
            Text(
              musicName,
              maxLines: 1,
            ),
            Text(message),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  static void alreadyDownloadedSnackBar(
    BuildContext context,
    String message,
  ) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Column(
          children: [
            Text(message),
          ],
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }
}
