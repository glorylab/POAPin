import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/components/icons/forward.dart';
import 'package:poapin/ui/pages/detail/controller.dart';
import 'package:poapin/ui/pages/detail/views/card.holders_preview.dart';
import 'package:poapin/ui/pages/detail/views/card.moments_preview.dart';
import 'package:gradient_ui/gradient_ui_widgets.dart' as a;

class DetailView extends StatelessWidget {
  final double contentWidth;
  final bool isHorizontal;
  final DetailController controller;
  final BuildContext context;

  const DetailView(
      {Key? key,
      required this.controller,
      required this.isHorizontal,
      required this.contentWidth,
      required this.context})
      : super(key: key);

  Widget _buildID(String id) {
    Gradient g1 = const LinearGradient(
      colors: [
        Color(0xFF7F00FF),
        Color(0xFFE100FF),
      ],
    );
    return Container(
      height: 48,
      alignment: Alignment.centerLeft,
      color: Colors.white,
      child: RawMaterialButton(
        fillColor: Colors.white,
        elevation: 0,
        focusElevation: 0,
        highlightElevation: 0,
        hoverElevation: 0,
        onLongPress: () {
          controller.copy(id);
        },
        onPressed: () {
          if (controller.token.value.layer == null) {
            return;
          }
          if (controller.token.value.layer == "Layer2") {
            controller.launchURL('blockscout.com',
                'xdai/mainnet/token/0x22c1f6050e56d2876009903609a2cc3fef83b415/instance/$id/token-transfers');
          } else {
            controller.launchURL('etherscan.io',
                'nft/0x22c1f6050e56d2876009903609a2cc3fef83b415/$id');
          }
        },
        child: Container(
          height: 48,
          alignment: Alignment.centerLeft,
          padding: const EdgeInsets.symmetric(horizontal: 8),
          child: a.GradientText(
            'id: #$id',
            gradient: g1,
            textAlign: TextAlign.center,
            style: GoogleFonts.robotoMono(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black38,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOwner(String owner) {
    Gradient g1 = const LinearGradient(
      colors: [
        Color(0xFF7F00FF),
        Color(0xFFE100FF),
      ],
    );
    return GetBuilder<DetailController>(
      builder: (c) => InkWell(
        onTap: () {
          if (c.token.value.layer == null) {
            return;
          }
          if (c.token.value.layer == "Layer2") {
            c.launchURL('blockscout.com',
                'xdai/mainnet/address/$owner/tokens/0x22c1f6050e56d2876009903609a2cc3fef83b415/token-transfers');
          } else {
            c.launchURL('etherscan.io',
                'token/0x22c1f6050e56d2876009903609a2cc3fef83b415?a=$owner');
          }
        },
        onLongPress: () {
          c.copy(owner);
        },
        child: Container(
          height: 48,
          width: Get.size.width * 0.9,
          padding: const EdgeInsets.only(left: 8),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [Color(0xFFF8F8F8), Color(0x00FFFFFF)])),
          alignment: Alignment.centerLeft,
          child: a.GradientText(
            c.ownerENS.isNotEmpty
                ? 'owner: ${c.ownerENS} (${c.getSimpleAddress(owner)})'
                : 'owner: ${c.getSimpleAddress(owner)}',
            gradient: g1,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: GoogleFonts.robotoMono(
              fontSize: 14,
              fontWeight: FontWeight.w500,
              color: Colors.black38,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildOrderAndTotal(String order, String total) {
    return Container(
      height: 48,
      color: Colors.white,
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(horizontal: 2),
      child: Row(
        children: [
          Text(
            order,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.right,
            style: GoogleFonts.robotoMono(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black12,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            '/',
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            style: GoogleFonts.robotoMono(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black12,
            ),
          ),
          const SizedBox(
            width: 2,
          ),
          Text(
            total,
            maxLines: 1,
            softWrap: false,
            overflow: TextOverflow.fade,
            textAlign: TextAlign.left,
            style: GoogleFonts.robotoMono(
              fontSize: 18,
              fontWeight: FontWeight.w500,
              color: Colors.black12,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildLayerIcon(DetailController c) {
    if (c.token.value.layer == null) {
      return Container(
        width: 36,
        height: 48,
        color: Colors.white,
      );
    }

    return Container(
      alignment: Alignment.center,
      width: 36,
      height: 48,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(0),
      ),
      child: Image.asset(
        c.token.value.layer == 'Layer2'
            ? 'icons/ic_gnosis.png'
            : 'icons/ic_eth.png',
        package: 'web3_icons',
        width: 18.0,
        height: 18.0,
      ),
    );
  }

  SliverChildListDelegate _detailDelegate({required bool isHorizontal}) {
    return SliverChildListDelegate([
      isHorizontal
          ? Container(
              padding: const EdgeInsets.only(
                  left: 16, right: 16, top: 8, bottom: 16),
              margin: const EdgeInsets.only(bottom: 12),
              alignment: Alignment.centerLeft,
              child: const POAPTitle(),
            )
          : Container(),
      Container(
        height: 48,
        margin: EdgeInsets.symmetric(horizontal: isHorizontal ? 8 : 8),
        child: Material(
          color: Colors.white,
          elevation: 8,
          clipBehavior: Clip.antiAlias,
          shadowColor: Colors.black12,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16),
                topRight: Radius.circular(16),
                bottomLeft: Radius.circular(0),
                bottomRight: Radius.circular(0)),
          ),
          child: Obx(
            () => Row(
              children: [
                _buildID(controller.tokenID.value),
                GetBuilder<DetailController>(
                  builder: (c) => _buildOrderAndTotal(c.order, c.total),
                ),
                Expanded(
                    child: Container(
                  color: Colors.white,
                )),
                _buildLayerIcon(controller),
              ],
            ),
          ),
        ),
      ),
      Container(
        height: 30,
        margin: EdgeInsets.symmetric(horizontal: isHorizontal ? 8 : 8),
        child: Material(
          color: PColor.background,
          elevation: 8,
          shadowColor: Colors.black12,
          clipBehavior: Clip.antiAlias,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(0),
                topRight: Radius.circular(0),
                bottomLeft: Radius.circular(16),
                bottomRight: Radius.circular(16)),
          ),
          child: Row(
            children: [
              Expanded(
                child: _buildOwner(controller.token.value.owner),
              ),
            ],
          ),
        ),
      ),
      const SizedBox(height: 16),
      const HoldersPreviewCard(),
      const MomentsPreviewCard(),
      const SizedBox(height: 32),
      const SizedBox(height: 78),
    ]);
  }

  @override
  Widget build(BuildContext context) {
    if (controller.status.value == LoadingStatus.loaded &&
        controller.token.value.event.fancyID != '') {
      return SliverStickyHeader.builder(
        builder: (context, state) => isHorizontal
            ? Container()
            : Material(
                elevation: state.isPinned ? 16 : 0,
                shadowColor: Colors.black45,
                color: Colors.transparent,
                child: Container(
                  color: PColor.background,
                  padding: const EdgeInsets.only(
                      left: 8, right: 8, top: 8, bottom: 4),
                  margin: const EdgeInsets.only(bottom: 12),
                  alignment: Alignment.centerLeft,
                  child: const POAPTitle(),
                ),
              ),
        sliver: SliverList(
          delegate: _detailDelegate(isHorizontal: isHorizontal),
        ),
      );
    } else {
      return SliverToBoxAdapter(
        child: Container(),
      );
    }
  }
}

class POAPTitle extends StatelessWidget {
  const POAPTitle({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      builder: (c) => RawMaterialButton(
        onPressed: () async {
          await Get.toNamed(
            '/event/${c.token.value.event.id}',
            arguments: {
              'event': c.token.value.event,
            },
          );
        },
        shape: ContinuousRectangleBorder(
          borderRadius: BorderRadius.circular(16),
          side: BorderSide(
            color: PColor.background,
          ),
        ),
        fillColor: Colors.white,
        elevation: 0,
        hoverElevation: 2,
        highlightElevation: 4,
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                c.isGitPOAP
                    ? Container(
                        margin: const EdgeInsets.only(right: 0),
                        child: RawMaterialButton(
                          constraints:
                              const BoxConstraints(minHeight: 32, minWidth: 32),
                          shape: const CircleBorder(),
                          onPressed: () {
                            c.launchGitPOAP(c.gitPOAPID);
                          },
                          child: Container(
                            padding: const EdgeInsets.all(8),
                            child: Image.asset(
                              'icons/ic_gitpoap.png',
                              package: 'web3_icons',
                              width: 24.0,
                              height: 24.0,
                            ),
                          ),
                        ),
                      )
                    : Container(),
                Expanded(
                  child: Row(
                    children: [
                      Expanded(
                        child: Container(
                          padding: const EdgeInsets.all(8),
                          child: Text(
                            c.token.value.event.name,
                            maxLines: 3,
                            softWrap: true,
                            overflow: TextOverflow.ellipsis,
                            style: GoogleFonts.lato(
                              fontSize: 24,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                      const ForwardIcon(),
                      const SizedBox(width: 8),
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                const SizedBox(width: 8),
                Expanded(
                  child: Text(
                    c.token.value.event.description,
                    maxLines: 3,
                    softWrap: true,
                    overflow: TextOverflow.fade,
                    style: GoogleFonts.lato(
                      fontSize: 16,
                      color: Colors.black38,
                    ),
                  ),
                ),
                const SizedBox(width: 8),
              ],
            ),
            const SizedBox(height: 12),
          ],
        ),
      ),
    );
  }
}
