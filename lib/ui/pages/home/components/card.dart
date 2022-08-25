import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/pages/home/components/card.moment.dart';
import 'package:poapin/ui/pages/home/components/card.poap.dart';
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
                child: ListView(
                  scrollDirection: Axis.horizontal,
                  children: const [
                    POAPCard(),
                    MomentCard(),
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
    return SizedBox(
      width: 245,
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
