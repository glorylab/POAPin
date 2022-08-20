import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/data/models/pref/layout.dart';
import 'package:poapin/data/models/pref/shape.dart';
import 'package:poapin/data/models/pref/sort.dart';
import 'package:poapin/ui/pages/home/components/button.clip_shape.dart';
import 'package:poapin/ui/pages/home/components/button.layout.dart';
import 'package:poapin/ui/pages/home/components/button.sort_by.dart';
import 'package:poapin/ui/pages/home/components/wrapper.bottomsheet.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class OverlayOptionsView extends StatelessWidget {
  const OverlayOptionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return const BottomSheetWrapper(
      content: OptionsView(),
    );
  }
}

class FlatOptionsView extends StatelessWidget {
  const FlatOptionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {},
      mouseCursor: MouseCursor.uncontrolled,
      splashColor: Colors.transparent,
      highlightColor: Colors.transparent,
      focusColor: Colors.transparent,
      hoverColor: Colors.transparent,
      onHover: (value) {
        Get.find<HomeController>().setIsWebOptionHover(value);
      },
      child: GetBuilder<HomeController>(
        builder: (c) => AnimatedOpacity(
          opacity: Get.find<HomeController>().isWebOptionHover ? 1 : 0.2,
          duration: const Duration(milliseconds: 300),
          child: Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [
                  Colors.white,
                  Colors.white.withOpacity(0.0),
                ],
              ),
            ),
            height: double.infinity,
            alignment: Alignment.topCenter,
            child: const OptionsView(),
          ),
        ),
      ),
    );
  }
}

class OptionsView extends StatelessWidget {
  const OptionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      children: [
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            strSort,
            style: GoogleFonts.epilogue(fontSize: 16, color: Colors.black54),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 56,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: 16,
              ),
              SortByButton(
                icon: Icons.arrow_upward,
                label: strNewest,
                sortBy: SortPref.timeAsc,
              ),
              const SizedBox(
                width: 8,
              ),
              SortByButton(
                icon: Icons.arrow_downward,
                label: strOldest,
                sortBy: SortPref.timeDesc,
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            strShape,
            style: GoogleFonts.epilogue(fontSize: 16, color: Colors.black54),
          ),
        ),
        const SizedBox(height: 16),
        SizedBox(
          height: 112,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: 16,
              ),
              Builder(builder: (context) {
                return const ClipShapeButton(
                  shape: ShapePref.square,
                  image: 'shape_square',
                );
              }),
              const SizedBox(
                width: 8,
              ),
              const ClipShapeButton(
                shape: ShapePref.round,
                image: 'shape_circle',
              ),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Text(
            'Layout',
            style: GoogleFonts.epilogue(fontSize: 16, color: Colors.black54),
          ),
        ),
        const SizedBox(height: 16),
        Container(
          constraints:
              BoxConstraints(maxWidth: MediaQuery.of(context).size.width / 2),
          height: 112,
          child: ListView(
            scrollDirection: Axis.horizontal,
            children: [
              const SizedBox(
                width: 16,
              ),
              Builder(builder: (context) {
                return const LayoutButton(
                  layout: LayoutPref.grid,
                  image: 'layout_grid',
                );
              }),
              const SizedBox(
                width: 8,
              ),
              Builder(builder: (context) {
                return const LayoutButton(
                  layout: LayoutPref.list,
                  image: 'layout_list',
                );
              }),
              const SizedBox(
                width: 8,
              ),
              Builder(builder: (context) {
                return const LayoutButton(
                  isDisabled: false,
                  layout: LayoutPref.timeline,
                  image: 'layout_timeline',
                );
              }),
              const SizedBox(
                width: 16,
              ),
            ],
          ),
        ),
        const SizedBox(height: 24),
      ],
    );
  }
}
