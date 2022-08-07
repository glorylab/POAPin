import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertBoard extends StatelessWidget {
  final String text;
  final Color textColor;
  final String image;
  final Widget? button;

  const AlertBoard(
      {Key? key, required this.text, this.button, required this.textColor,required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Image.asset(
            image,
            height: 192,
            width: 192,
          ),
          const SizedBox(height: 8),
          Text(
            text,
            style: GoogleFonts.epilogue(
              color: textColor,
              fontSize: 18,
            ),
          ),
          const SizedBox(height: 56),
          button ?? Container(),
        ],
      ),
    );
  }
}
