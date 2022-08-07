import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/data/models/pref/layout.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class LayoutButton extends StatelessWidget {
  final LayoutPref layout;
  final String image;
  final bool isDisabled;

  const LayoutButton(
      {Key? key,
      required this.layout,
      required this.image,
      this.isDisabled = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => ColorFiltered(
          colorFilter: c.layout == layout
              ? const ColorFilter.mode(
                  Colors.transparent,
                  BlendMode.multiply,
                )
              : ColorFilter.mode(
                  Colors.grey.shade50,
                  BlendMode.saturation,
                ),
          child: OutlinedButton(
            onPressed: isDisabled
                ? () {
                    Get.showSnackbar(const GetSnackBar(
                      title: 'Coming soon!',
                      message: 'Thank you for your patience.',
                      duration: Duration(seconds: 2),
                    ));
                  }
                : () {
                    c.setLayout(layout);
                  },
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Image.asset('assets/common/$image.png', width: 79, height: 79),
                Text(
                  layout.toShortString(),
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
