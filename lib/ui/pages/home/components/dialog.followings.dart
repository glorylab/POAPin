import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/home/controllers/card.social.dart';

class FollowingsDialog extends StatelessWidget {
  const FollowingsDialog({Key? key, required this.followings})
      : super(key: key);

  final List<Map<String, String>> followings;

  Widget _buildFollingItem(Map<String, String> follower) {
    return Card(
      shape: ContinuousRectangleBorder(
        borderRadius: BorderRadius.circular(16),
      ),
      color: Colors.white,
      elevation: 0,
      shadowColor: Colors.black26,
      child: Container(
        padding: const EdgeInsets.symmetric(
          horizontal: 16,
          vertical: 12,
        ),
        child: Row(
          children: [
            follower.values.first == '-'
                ? SizedBox(
                    width: 12,
                    height: 12,
                    child: CircularProgressIndicator(
                      strokeWidth: 0.6,
                      valueColor:
                          AlwaysStoppedAnimation<Color>(Colors.indigo.shade300),
                    ),
                  )
                : follower.values.first == ''
                    ? Container()
                    : Text(
                        follower.values.first,
                        style: GoogleFonts.robotoMono(
                          color: Colors.black87,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
            follower.values.first == ''
                ? Container()
                : const SizedBox(
                    width: 16,
                  ),
            Expanded(
              child: Text(
                Get.find<SocialCardController>()
                    .getSimpleAddress(follower.keys.first),
                overflow: TextOverflow.fade,
                maxLines: 1,
                softWrap: false,
                textAlign: follower.values.first == ''
                    ? TextAlign.left
                    : TextAlign.end,
                style: GoogleFonts.robotoMono(
                  color: follower.values.first == ''
                      ? Colors.black87
                      : Colors.black38,
                  fontWeight: FontWeight.bold,
                  fontSize: follower.values.first == '' ? 14 : 10,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildFollowingsContent() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 72),
          ...followings.map((f) => _buildFollingItem(f)),
          const SizedBox(height: 40),
        ],
      ),
    );
  }

  Widget _buildEmptyContent() {
    return Container(
      padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
      child: ListView(
        shrinkWrap: true,
        children: [
          const SizedBox(height: 72),
          Text(
            'Save your friends\' collections on the official POAP app.',
            style: GoogleFonts.roboto(
              fontSize: 16,
              height: 1.5,
            ),
          ),
          const SizedBox(height: 32),
          RawMaterialButton(
            onPressed: () {
              Get.find<SocialCardController>().launchPOAP();
            },
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(24),
            ),
            fillColor: PColor.primary,
            elevation: 0,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: Text(
                'Go to POAP.xyz',
                style: GoogleFonts.roboto(
                  fontSize: 16,
                  fontWeight: FontWeight.w500,
                  color: Colors.white,
                  letterSpacing: 1.1,
                ),
              ),
            ),
          ),
          const SizedBox(height: 8),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(left: 32, right: 32, bottom: 44, top: 32),
        child: Material(
          color: PColor.background,
          shadowColor: Colors.black54,
          elevation: 8,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(56)),
            side: BorderSide(color: Color(0xFFD2D2D2), width: 4),
          ),
          clipBehavior: Clip.antiAlias,
          child: Container(
            constraints: const BoxConstraints(
                maxWidth: 300, minWidth: 280, minHeight: 128, maxHeight: 512),
            child: Stack(
              children: [
                GetBuilder<SocialCardController>(builder: (c) {
                  if (c.followingsWithENS.isNotEmpty) {
                    return _buildFollowingsContent();
                  } else {
                    return _buildEmptyContent();
                  }
                }),
                Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
                  child: Material(
                    elevation: 20,
                    shadowColor: Colors.black26,
                    shape: const ContinuousRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(56)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 14),
                      width: double.infinity,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Image.asset(
                            'icons/ic_poap.png',
                            package: 'web3_icons',
                            height: 24,
                          ),
                          const SizedBox(width: 8),
                          Text(
                            strFollowings,
                            style: GoogleFonts.robotoMono(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: PColor.primary),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            '[${followings.length}]',
                            style: GoogleFonts.robotoMono(
                                fontSize: 18,
                                fontWeight: FontWeight.w500,
                                color: PColor.primary),
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
      ),
    );
  }
}
