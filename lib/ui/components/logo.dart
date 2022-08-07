import 'package:flutter/material.dart';

class POAPinLogo extends StatelessWidget {
  const POAPinLogo({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return  Center(
      child:Container(
        margin: const EdgeInsets.only(left: 16,top:16),
        width: 88,
        height: 88,
        child: Stack(
        fit: StackFit.loose,
        clipBehavior: Clip.hardEdge,
          children: [
            Image.asset('assets/common/logo_bottom.png'),
            Image.asset('assets/common/logo_top.png'),
          ],
        ),
      ),
    );
  }
}
