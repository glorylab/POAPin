import 'package:flutter/material.dart';

class ScrollVelocityListener extends StatefulWidget {
  final Function(double) onVelocity;
  final Widget child;

  const ScrollVelocityListener({
    Key? key,
    required this.onVelocity,
    required this.child,
  }) : super(key: key);

  @override
  State<StatefulWidget> createState() => _ScrollVelocityListenerState();
}

class _ScrollVelocityListenerState extends State<ScrollVelocityListener> {
  int lastMilli = DateTime.now().millisecondsSinceEpoch;

  @override
  Widget build(BuildContext context) {
    return NotificationListener<ScrollNotification>(
      onNotification: (notification) {
        final now = DateTime.now();
        final timeDiff = now.millisecondsSinceEpoch - lastMilli;
        if (notification is ScrollUpdateNotification) {
          final pixelsPerMilli = notification.scrollDelta! / timeDiff;
          widget.onVelocity(
            pixelsPerMilli,
          );
          lastMilli = DateTime.now().millisecondsSinceEpoch;
        }

        if (notification is ScrollEndNotification) {
          widget.onVelocity(0);
          lastMilli = DateTime.now().millisecondsSinceEpoch;
        }

        return true;
      },
      child: widget.child,
    );
  }
}
