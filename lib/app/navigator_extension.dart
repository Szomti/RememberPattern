import 'package:flutter/material.dart';

typedef PageBuilder = Widget Function(
  BuildContext,
  Animation<double>,
  Animation<double>,
);

extension NavigatorExtension on Navigator {
  Future<void> pushNoAnimation(
    BuildContext context,
      PageBuilder pageBuilder,
  ) async {
    await Navigator.push(
      context,
      PageRouteBuilder(
        pageBuilder: pageBuilder,
        transitionDuration: Duration.zero,
        reverseTransitionDuration: Duration.zero,
      ),
    );
  }
}
