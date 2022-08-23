import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterTag extends StatelessWidget {
  final String title;
  final String value;
  final Function() onPressed;
  final Function() onClearPressed;

  const FilterTag({
    Key? key,
    required this.title,
    required this.value,
    required this.onPressed,
    required this.onClearPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: onPressed,
            padding: const EdgeInsets.only(left: 8, right: 4),
            constraints: const BoxConstraints(minWidth: 16),
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lato(color: Colors.blueGrey),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      ':',
                      style: GoogleFonts.lato(color: Colors.blueGrey),
                    ),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.lato(
                      color: Colors.orangeAccent.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          value.isEmpty
              ? Container()
              : RawMaterialButton(
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: onClearPressed,
                  shape: const CircleBorder(),
                  highlightColor: Colors.red.shade200.withOpacity(0.3),
                  splashColor: Colors.redAccent.shade200.withOpacity(0.3),
                  child: Icon(Icons.cancel,
                      size: 18, color: Colors.blueGrey.shade100),
                ),
        ],
      ),
    );
  }
}
