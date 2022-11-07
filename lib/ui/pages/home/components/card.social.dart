import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/home/controllers/card.social.dart';

class SocialCard extends StatelessWidget {
  const SocialCard({Key? key}) : super(key: key);

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
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Expanded(
                child: GetBuilder<SocialCardController>(
                  builder: (c) => RawMaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    hoverElevation: 0,
                    onPressed: () {
                      c.showFollowersDialog();
                    },
                    fillColor: Colors.white,
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
                                    strFollowers,
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
                                  child: c.isLoadingFollowers
                                      ? Container(
                                          width: 12,
                                          height: 12,
                                          margin: const EdgeInsets.only(top: 8),
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 1,
                                            color: Colors.indigo,
                                          ),
                                        )
                                      : FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            c.followersWithENS.length
                                                .toString(),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              Container(
                height: 0.6,
                width: double.infinity,
                margin: const EdgeInsets.symmetric(horizontal: 8),
                color: PColor.background,
              ),
              Expanded(
                child: GetBuilder<SocialCardController>(
                  builder: (c) => RawMaterialButton(
                    elevation: 0,
                    highlightElevation: 0,
                    hoverElevation: 0,
                    onPressed: () {
                      c.showFollowingsDialog();
                    },
                    fillColor: Colors.white,
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
                                    strFollowings,
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
                                  child: c.isLoadingFollowings
                                      ? Container(
                                          width: 12,
                                          height: 12,
                                          margin: const EdgeInsets.only(top: 8),
                                          child:
                                              const CircularProgressIndicator(
                                            strokeWidth: 1,
                                            color: Colors.indigo,
                                          ),
                                        )
                                      : FittedBox(
                                          fit: BoxFit.scaleDown,
                                          child: Text(
                                            c.followingsWithENS.length
                                                .toString(),
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
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
