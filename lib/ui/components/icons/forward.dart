import 'package:flutter/material.dart';

class ForwardIcon extends StatelessWidget {
  const ForwardIcon({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const Icon(
      Icons.arrow_forward_ios_rounded,
      size: 16,
      color: Colors.black26,
    );
  }
}
