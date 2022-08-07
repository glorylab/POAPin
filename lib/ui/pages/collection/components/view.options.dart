import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/data/models/pref/layout.dart';
import 'package:poapin/data/models/pref/shape.dart';
import 'package:poapin/data/models/pref/sort.dart';
import 'package:poapin/ui/pages/collection/components/button.clip_shape.dart';
import 'package:poapin/ui/pages/collection/components/button.layout.dart';
import 'package:poapin/ui/pages/collection/components/button.sort_by.dart';

class OptionsView extends StatelessWidget {
  const OptionsView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        constraints: BoxConstraints(
            maxWidth: 512,
            maxHeight: 7 * MediaQuery.of(context).size.height / 11),
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: Material(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 16,
          child: SafeArea(
            child: Column(
              children: [
                Expanded(
                  child: ListView(
                    shrinkWrap: true,
                    children: [
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Sort',
                          style: GoogleFonts.epilogue(
                              fontSize: 16, color: Colors.black54),
                        ),
                      ),
                      const SizedBox(height: 16),
                      SizedBox(
                        height: 56,
                        child: ListView(
                          scrollDirection: Axis.horizontal,
                          children: const [
                            SizedBox(
                              width: 16,
                            ),
                            SortByButton(
                              icon: Icons.arrow_upward,
                              label: 'from NEW to OLD',
                              sortBy: SortPref.timeAsc,
                            ),
                            SizedBox(
                              width: 8,
                            ),
                            SortByButton(
                              icon: Icons.arrow_downward,
                              label: 'from OLD to NEW',
                              sortBy: SortPref.timeDesc,
                            ),
                            SizedBox(
                              width: 16,
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 24),
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 16),
                        child: Text(
                          'Shape',
                          style: GoogleFonts.epilogue(
                              fontSize: 16, color: Colors.black54),
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
                          style: GoogleFonts.epilogue(
                              fontSize: 16, color: Colors.black54),
                        ),
                      ),
                      const SizedBox(height: 16),
                      Container(
                        constraints: BoxConstraints(
                            maxWidth: MediaQuery.of(context).size.width / 2),
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
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
