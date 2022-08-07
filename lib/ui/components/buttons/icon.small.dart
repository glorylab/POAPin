import 'package:flutter/material.dart';

class SmallMenuButton extends StatelessWidget {
  final IconData iconData;
  final Function() onPressed;
  const SmallMenuButton({Key? key, required this.iconData, required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.white,
      elevation: 0,
      hoverElevation: 4,
      materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
      constraints: const BoxConstraints(minWidth: 36.0, minHeight: 36.0),
      onPressed: onPressed,
      child: Row(
        children: [
          Icon(
            iconData,
            color: const Color(0xFF584593),
          ),
        ],
      ),
    );
  }
}
