import 'package:flutter/material.dart';
import 'package:flutter_sticky_header/flutter_sticky_header.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/components/buttons/back.dart';
import 'package:poapin/ui/components/buttons/go_home.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/gitpoaps/components/view.hive.dart';
import 'package:poapin/ui/pages/gitpoaps/controller.dart';

class GitPoapsPage extends BasePage<GitPoapsController> {
  const GitPoapsPage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  List<Widget> _buildContent(bool isExpanded, BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    int crossAxisCount = (screenWidth / 120).floor();
    double safePaddingLeft = MediaQuery.of(context).padding.left;
    double safePaddingRight = MediaQuery.of(context).padding.right;
    if (isExpanded) {
      return [
        SliverPadding(
          padding: EdgeInsets.only(
            left: 16 + safePaddingLeft,
            right: 16 + safePaddingRight,
            top: 12,
            bottom: 12,
          ),
          sliver: SliverToBoxAdapter(
            child: HiveView(
              columnCount: crossAxisCount,
              gitPOAPs: controller.gitPOAPs,
            ),
          ),
        )
      ];
    } else {
      return controller.gitPOAPsByOrganizationList
          .map(
            (a) => SliverStickyHeader.builder(
              sticky: false,
              builder: (context, state) => Container(
                padding: EdgeInsets.only(
                  left: 16 + safePaddingLeft,
                  right: 16 + safePaddingRight,
                ),
                color: Colors.white,
                child: Material(
                  color: Colors.white,
                  shape: ContinuousRectangleBorder(
                    borderRadius:
                        const BorderRadius.vertical(top: Radius.circular(24)),
                    side: BorderSide(color: PColor.background, width: 2),
                  ),
                  shadowColor: Colors.black12,
                  elevation: 0,
                  child: Container(
                    height: 48,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    alignment: Alignment.centerLeft,
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Text(
                          a.keys.first,
                          style: GoogleFonts.robotoMono(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: PColor.welookDark.withOpacity(0.8),
                          ),
                        ),
                        const SizedBox(width: 8),
                        Text(
                          '<${a.values.first.length}>',
                          style: GoogleFonts.robotoMono(
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                            color: PColor.welookDark.withOpacity(0.4),
                          ),
                        ),
                        Expanded(
                          child: Container(),
                        ),
                        IconButton(
                          onPressed: () {
                            controller.launchGitHubOrg(a.keys.first);
                          },
                          icon: Image.asset(
                            'icons/ic_github.png',
                            package: 'web3_icons',
                            height: 16,
                            width: 16,
                            color: PColor.welookDark.withOpacity(0.5),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
              sliver: SliverPadding(
                padding: EdgeInsets.only(
                  left: 16 + safePaddingLeft,
                  right: 16 + safePaddingRight,
                  bottom: 24,
                ),
                sliver: SliverToBoxAdapter(
                  child: HiveView(
                    columnCount: crossAxisCount,
                    gitPOAPs: a.values.first,
                  ),
                ),
              ),
            ),
          )
          .toList();
    }
  }

  @override
  Widget getPage(BuildContext context) {
    return Material(
      color: Colors.white,
      child: GetBuilder<GitPoapsController>(
        builder: (c) => Scrollbar(
          child: CustomScrollView(
            slivers: [
              SliverAppBar(
                expandedHeight: 120,
                pinned: true,
                leading: Get.previousRoute == ''
                    ? const GoHomeButton()
                    : const GoBackButton(),
                automaticallyImplyLeading: true,
                centerTitle: true,
                elevation: 0,
                shadowColor: PColor.gitpoap.withOpacity(0.5),
                title: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Image.asset(
                      'icons/ic_gitpoap_full.png',
                      package: 'web3_icons',
                      height: 24,
                    ),
                    const SizedBox(width: 8),
                    Container(
                      height: 24,
                      constraints: const BoxConstraints(minWidth: 24),
                      decoration: BoxDecoration(
                        color: const Color.fromARGB(30, 236, 72, 154),
                        borderRadius: const BorderRadius.all(
                          Radius.circular(10),
                        ),
                        border: Border.all(
                          color: PColor.gitpoap.withOpacity(0.3),
                          width: 2,
                        ),
                      ),
                      alignment: Alignment.center,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      child: Text(
                        '${c.gitPOAPs.length}',
                        style: GoogleFonts.robotoMono(
                          fontSize: 12,
                          color: PColor.gitpoap,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    )
                  ],
                ),
                collapsedHeight: kToolbarHeight + 40,
                flexibleSpace: FlexibleSpaceBar(
                  collapseMode: CollapseMode.parallax,
                  background: Container(
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          stops: const [0.0, 1.0],
                          colors: [PColor.gitpoap, Colors.white]),
                    ),
                  ),
                  titlePadding: const EdgeInsets.only(
                      top: 16, bottom: 8, left: 16, right: 16),
                  title: Card(
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    elevation: 0,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 4),
                      child: Text(
                        c.getENSorETH(c.address),
                        maxLines: 1,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.robotoMono(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: PColor.welookDark.withOpacity(0.8),
                        ),
                      ),
                    ),
                  ),
                ),
                actions: [
                  IconButton(
                    icon: c.isExpanded
                        ? const Icon(Icons.unfold_more_rounded)
                        : const Icon(Icons.unfold_less_rounded),
                    color: PColor.gitpoap,
                    onPressed: () => c.toggleIsExpanded(),
                  ),
                ],
              ),
              ..._buildContent(c.isExpanded, context),
            ],
          ),
        ),
      ),
    );
  }
}
