import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class FilterTitle extends StatelessWidget {
  final String title;

  const FilterTitle({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 56,
      alignment: Alignment.centerRight,
      margin: const EdgeInsets.only(left: 8, right: 8),
      child: Text(
        title,
        style: GoogleFonts.epilogue(
          color: Colors.black38,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
    );
  }
}
