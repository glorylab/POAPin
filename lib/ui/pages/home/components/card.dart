import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/pages/home/components/chart.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class CollectionCard extends StatelessWidget {
  const CollectionCard(
      {Key? key,
      required this.horizontalPadding,
      required this.horizonTalPaddingWithMenu})
      : super(key: key);
  final double horizontalPadding;
  final double horizonTalPaddingWithMenu;

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => SizedBox(
        height: 160,
        width: double.infinity,
        child: (c.error.value == '' && c.poapCount > 0)
            ? Padding(
                padding: const EdgeInsets.only(
                    left: 16, right: 16, bottom: 0, top: 8),
                child: Row(
                  children: [
                    _CountCard(),
                    _ChartCard(),
                  ],
                ),
              )
            : Container(),
      ),
    );
  }
}

class _ChartCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Card(
        clipBehavior: Clip.antiAlias,
        elevation: 16,
        shape: const ContinuousRectangleBorder(
            side: BorderSide(color: Colors.white70, width: 1),
            borderRadius: BorderRadius.all(Radius.circular(24))),
        shadowColor: Colors.black26,
        child: GetBuilder<HomeController>(
          builder: (c) => InkWell(
            onTap: () {
              c.toggleChartView();
            },
            child: Stack(
              children: [
                Positioned(
                    top: 16,
                    left: 16,
                    child: Text(
                      c.chartView == 'heatmap'
                          ? ''
                          : c.chartView == 'growth'
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
    );
  }
}

class _CountCard extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Card(
      clipBehavior: Clip.antiAlias,
      elevation: 16,
      shape: const ContinuousRectangleBorder(
          side: BorderSide(color: Colors.white70, width: 1),
          borderRadius: BorderRadius.all(Radius.circular(24))),
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
                    GetBuilder<HomeController>(
                      builder: (c) => Text(
                        c.filteredEventsCount < c.eventCount
                            ? c.filteredEventsCount.toString() +
                                '/' +
                                c.eventCount.toString()
                            : c.eventCount.toString(),
                        style: GoogleFonts.shareTechMono(
                          color: Colors.black54,
                          fontSize: 18,
                        ),
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
                      strPOAPs,
                      style: GoogleFonts.shareTechMono(
                        color: Colors.black45,
                        fontWeight: FontWeight.bold,
                        fontSize: 14,
                      ),
                    ),
                    GetBuilder<HomeController>(
                      builder: (c) => Text(
                        c.filteredPOAPCount == 0
                            ? c.poapCount.toString()
                            : c.filteredPOAPCount < c.poapCount
                                ? c.filteredPOAPCount.toString() +
                                    '/' +
                                    c.poapCount.toString()
                                : c.poapCount.toString(),
                        style: GoogleFonts.shareTechMono(
                          color: Colors.black87,
                          fontSize: 26,
                        ),
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
    );
  }
}
