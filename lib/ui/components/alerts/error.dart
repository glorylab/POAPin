import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/components/alerts/alert.dart';

class ErrorBoard extends StatelessWidget {
  final String text;

  const ErrorBoard({Key? key, required this.text}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return AlertBoard(
      image: 'assets/common/error.png',
      text: text,
      textColor: Colors.black54,
      button: RawMaterialButton(
        fillColor: Colors.white,
        elevation: 0.0,
        hoverElevation: 16.0,
        focusElevation: 12.0,
        highlightElevation: 12.0,
        onPressed: () {
          Get.toNamed("/home");
        },
        shape: const StadiumBorder(),
        child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
          child: Text(
            'Go Home',
            style: GoogleFonts.carterOne(
              color: const Color(0xFF6534FF),
              fontSize: 18,
            ),
          ),
        ),
      ),
    );
  }
}
