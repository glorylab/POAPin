import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/data/models/pref/shape.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class ClipShapeButton extends StatelessWidget {
  const ClipShapeButton({Key? key, required this.shape, required this.image})
      : super(key: key);
  final ShapePref shape;
  final String image;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => ColorFiltered(
          colorFilter: c.shape == shape
              ? const ColorFilter.mode(
                  Colors.transparent,
                  BlendMode.multiply,
                )
              : ColorFilter.mode(
                  Colors.grey.shade50,
                  BlendMode.saturation,
                ),
          child: OutlinedButton(
            onPressed: () {
              c.setShape(shape);
            },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/common/$image.png', width: 128, height: 79),
                Text(
                  shape.toShortString(),
                  style: GoogleFonts.epilogue(),
                ),
                const SizedBox(
                  height: 8,
                ),
              ],
            ),
          )),
    );
  }
}
