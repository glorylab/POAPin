import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/components/icons/forward.dart';
import 'package:poapin/ui/pages/detail/controller.dart';

class MomentsPreviewCard extends StatelessWidget {
  const MomentsPreviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      builder: (c) {
        if (c.momentsCount == 0) {
          return Container();
        }
        return Container(
          height: 48 + 88,
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
          child: SizedBox(
            height: 48 + 88,
            child: Material(
              elevation: 8,
              clipBehavior: Clip.antiAlias,
              shadowColor: Colors.black12,
              color: Colors.white,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(
                  Radius.circular(16),
                ),
              ),
              child: RawMaterialButton(
                onPressed: () {
                  c.launchWelook(c.token.value.event.id);
                },
                fillColor: Colors.white,
                splashColor: const Color(0x22EC4899),
                highlightColor: const Color(0x0BEC4899),
                elevation: 0,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    SizedBox(
                      height: 48,
                      child: Row(
                        children: [
                          const SizedBox(width: 12),
                          Image.asset(
                            'icons/ic_moments.png',
                            package: 'web3_icons',
                            width: 105,
                            height: 18,
                          ),
                          const SizedBox(width: 8),
                          c.momentsCount > 0
                              ? Container(
                                  height: 30,
                                  constraints:
                                      const BoxConstraints(minWidth: 32),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(30, 236, 72, 154),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                      color: const Color(0x55EC4899),
                                      width: 3,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  child: Text(
                                    '${c.momentsCount}',
                                    style: GoogleFonts.robotoMono(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 236, 72, 154),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                )
                              : Container(
                                  height: 30,
                                  constraints:
                                      const BoxConstraints(minWidth: 32),
                                  decoration: BoxDecoration(
                                    color:
                                        const Color.fromARGB(30, 236, 72, 154),
                                    borderRadius: const BorderRadius.all(
                                      Radius.circular(10),
                                    ),
                                    border: Border.all(
                                      color: const Color(0x55EC4899),
                                      width: 3,
                                    ),
                                  ),
                                  alignment: Alignment.center,
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 4, vertical: 2),
                                  child: Text(
                                    '+',
                                    style: GoogleFonts.robotoMono(
                                      fontSize: 16,
                                      color: const Color.fromARGB(
                                          255, 236, 72, 154),
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                          Expanded(child: Container()),
                          Image.asset(
                            'icons/ic_welook.png',
                            package: 'web3_icons',
                            width: 64,
                            height: 18,
                            color: const Color.fromARGB(30, 15, 23, 42),
                          ),
                          const SizedBox(width: 8),
                          const ForwardIcon(),
                          const SizedBox(width: 8),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 88,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        children: c.moments
                            .map((m) =>
                                c.buildPreviewImage(c.getPreviewImageURL(m)))
                            .toList(),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
