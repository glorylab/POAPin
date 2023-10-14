import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/home/components/chart.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class POAPCard extends StatelessWidget {
  const POAPCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 100,
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 16,
        shape: const ContinuousRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(24))),
        shadowColor: Colors.black26,
        child: RawMaterialButton(
          onPressed: () {},
          fillColor: Colors.white,
          child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Expanded(
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(),
                      Container(
                        padding: const EdgeInsets.all(8),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Container(
                                alignment: Alignment.bottomCenter,
                                child: Text(
                                  strPoaps,
                                  style: GoogleFonts.shareTechMono(
                                    color: Colors.black45,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 14,
                                  ),
                                ),
                              ),
                            ),
                            const SizedBox(height: 4),
                            Expanded(
                              child: Container(
                                alignment: Alignment.topCenter,
                                child: GetBuilder<HomeController>(
                                  builder: (c) => FittedBox(
                                    fit: BoxFit.scaleDown,
                                    child: Text(
                                      c.filteredPOAPCount.toString(),
                                      maxLines: 1,
                                      softWrap: false,
                                      style: GoogleFonts.shareTechMono(
                                        color: Colors.black87,
                                        fontSize: 20,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 0.6,
                  width: double.infinity,
                  margin: const EdgeInsets.symmetric(horizontal: 8),
                  color: PColor.background,
                ),
                const Expanded(
                  child: TokenChart(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
