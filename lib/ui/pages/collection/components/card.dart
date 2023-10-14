import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/pages/collection/components/chart.dart';
import 'package:poapin/ui/pages/collection/controller.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard({Key? key, required this.horizontalPadding})
      : super(key: key);
  final double horizontalPadding;

  @override
  Widget build(BuildContext context) {
    CollectionController controller = Get.find<CollectionController>();

    return Obx(() => SizedBox(
        height: 160,
        width: double.infinity,
        child: (controller.error.value == '' && controller.count.value > 0)
            ? Padding(
                padding: EdgeInsets.only(
                    left: horizontalPadding,
                    right: horizontalPadding,
                    bottom: 0,
                    top: 8),
                child: Row(
                  children: [
                    Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 16,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      shadowColor: Colors.black26,
                      child: InkWell(
                        onTap: () {},
                        child: Center(
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              const SizedBox(height: 8),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      strEvents,
                                      style: GoogleFonts.shareTechMono(
                                        color: Colors.black38,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      controller.uniqueCount.value.toString(),
                                      style: GoogleFonts.shareTechMono(
                                        color: Colors.black54,
                                        fontSize: 18,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(
                                height: 8,
                              ),
                              Container(
                                padding: const EdgeInsets.all(8),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      strPoaps,
                                      style: GoogleFonts.shareTechMono(
                                        color: Colors.black45,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 14,
                                      ),
                                    ),
                                    Text(
                                      controller.count.value.toString(),
                                      style: GoogleFonts.shareTechMono(
                                        color: Colors.black87,
                                        fontSize: 26,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const SizedBox(height: 8),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                      child: Card(
                        clipBehavior: Clip.antiAlias,
                        elevation: 16,
                        shape: const RoundedRectangleBorder(
                            side: BorderSide(color: Colors.white70, width: 1),
                            borderRadius: BorderRadius.all(Radius.circular(8))),
                        shadowColor: Colors.black26,
                        child: InkWell(
                          onTap: () {
                            controller.toggleChartView();
                          },
                          child: Stack(
                            children: [
                              Positioned(
                                  top: 16,
                                  left: 16,
                                  child: Text(
                                    controller.chartView.value == 'growth'
                                        ? strGrowth
                                        : strMonthly,
                                    style: GoogleFonts.epilogue(
                                      fontSize: 16,
                                      color: Theme.of(context)
                                          .primaryColorDark
                                          .withOpacity(0.18),
                                      fontStyle: FontStyle.italic,
                                    ),
                                  )),
                              const TokenChart(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            : Container()));
  }
}
