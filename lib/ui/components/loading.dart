import 'package:flutter/material.dart';
import 'package:rive/rive.dart';

class LoadingAnimation extends StatelessWidget {
  const LoadingAnimation({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const SizedBox(
      width: 256,
      height: 256,
      child: RiveAnimation.asset('assets/animation/poapin_loading.riv'),
    );
  }
}
