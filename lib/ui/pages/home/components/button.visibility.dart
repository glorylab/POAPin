import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/data/models/pref/visibility.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class VisibilityButton extends StatelessWidget {
  const VisibilityButton(
      {Key? key,
      required this.icon,
      required this.label,
      required this.visibility})
      : super(key: key);

  final IconData icon;
  final String label;
  final VisibilityPref visibility;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => ColorFiltered(
        colorFilter: c.visibility == visibility
            ? const ColorFilter.mode(
                Colors.transparent,
                BlendMode.multiply,
              )
            : ColorFilter.mode(
                Colors.grey.shade50,
                BlendMode.saturation,
              ),
        child: OutlinedButton.icon(
            onPressed: () {
              c.setVisibility(visibility);
            },
            icon: Icon(icon),
            label: Text(
              label,
              style: GoogleFonts.epilogue(),
            )),
      ),
    );
  }
}
