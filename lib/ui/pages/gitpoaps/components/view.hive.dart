import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hexagon/hexagon.dart';
import 'package:poapin/data/models/gitpoap.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/gitpoaps/controller.dart';

class HiveView extends StatelessWidget {
  final int columnCount;
  final List<GitPoap> gitPOAPs;
  const HiveView({Key? key, required this.columnCount, required this.gitPOAPs})
      : super(key: key);

  // _getIndex(int col, int row) {
  //   return (col * columnCount) + row;
  // }

  _getVerticalIndex(int col, int row) {
    return (row * columnCount) + col;
  }

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.white,
      shape: ContinuousRectangleBorder(
        borderRadius: const BorderRadius.vertical(bottom: Radius.circular(24)),
        side: BorderSide(color: PColor.background, width: 2),
      ),
      shadowColor: Colors.black12,
      elevation: 16,
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: SizedBox(
          child: HexagonOffsetGrid.oddPointy(
            columns: columnCount,
            rows: (gitPOAPs.length / columnCount).ceil(),
            padding: const EdgeInsets.all(8),
            buildTile: (col, row) {
              return _getVerticalIndex(col, row) >= gitPOAPs.length
                  ? HexagonWidgetBuilder.transparent()
                  : HexagonWidgetBuilder(
                      elevation: 0.0,
                      padding: 4.0,
                      cornerRadius: 30,
                      color: const Color(0xFF10111e),
                      child: GestureDetector(
                        onTap: () {
                          Get.find<GitPoapsController>().jumpToPOAP(
                              gitPOAPs[_getVerticalIndex(col, row)]);
                        },
                        child: Container(
                          width: double.infinity,
                          height: double.infinity,
                          color: Colors.white,
                          child: Center(
                            child: ExtendedImage.network(
                                gitPOAPs[_getVerticalIndex(col, row)].imageURL),
                          ),
                        ),
                      ),
                    );
            },
          ),
        ),
      ),
    );
  }
}
