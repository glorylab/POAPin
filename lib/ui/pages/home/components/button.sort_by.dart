import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/data/models/pref/sort.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class SortByButton extends StatelessWidget {
  const SortByButton(
      {Key? key, required this.icon, required this.label, required this.sortBy})
      : super(key: key);

  final IconData icon;
  final String label;
  final SortPref sortBy;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => ColorFiltered(
        colorFilter: c.sortBy == sortBy
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
              c.setSortBy(sortBy);
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
