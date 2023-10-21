import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/home/components/appbar.journal.dart';
import 'package:poapin/ui/pages/journal/components/view.island.journal.dart';
import 'package:poapin/ui/pages/journal/controller.dart';

class JournalPage extends BasePage<JournalController> {
  const JournalPage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  @override
  Widget getPage(BuildContext context) {
    double screenHeight = MediaQuery.of(context).size.height;

    double statusBarHeight = MediaQuery.of(context).padding.top;

    double appBarHeight = kToolbarHeight + kBottomNavigationBarHeight;

    double sliverToBoxAdapterHeight =
        screenHeight - statusBarHeight - appBarHeight;

    return Container(
      decoration: const BoxDecoration(color: Color(0xFFF2F2F2)),
      child: Container(
        alignment: Alignment.center,
        width: MediaQuery.of(context).size.width,
        constraints: const BoxConstraints(
            maxWidth: 768, maxHeight: double.infinity, minWidth: 256),
        child: GetBuilder<JournalController>(
          builder: (c) => Stack(
            children: [
              ClipRect(
                child: AnimatedScale(
                  scale: c.isExpanded ? 1.1 : 1,
                  curve: Curves.easeInOutCubic,
                  duration: const Duration(milliseconds: 300),
                  child: CustomScrollView(
                      controller: c.scrollController,
                      slivers: [
                        const JournalAppBar(),
                        SliverToBoxAdapter(
                          child: Container(
                            height: sliverToBoxAdapterHeight,
                            // color: Colors.blue,
                            child: const Column(
                              children: [
                                Expanded(
                                  child: Center(
                                    child: Text('Journals'),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ]),
                ),
              ),

              TweenAnimationBuilder(
                  tween: IntTween(
                    begin: c.isIslandInit
                        ? 0
                        : c.isExpanded
                            ? 0
                            : 100,
                    end: c.isIslandInit
                        ? 0
                        : c.isExpanded
                            ? 100
                            : 0,
                  ),
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.easeInOutCubic,
                  builder: (context, int progress, child) {
                    return BackdropFilter(
                      filter: ImageFilter.blur(
                        sigmaX: 5.0 * progress / 100.0,
                        sigmaY: 5.0 * progress / 100.0,
                      ),
                      child: GestureDetector(
                        onTap: () {
                          c.setIslandExpanded(false);
                        },
                        onPanStart: (details) => c.setIslandExpanded(false),
                        child: IgnorePointer(
                          ignoring: !c.isExpanded,
                          child: Container(
                            color:
                                Colors.black.withOpacity(0.1 * progress / 100),
                          ),
                        ),
                      ),
                    );
                  }),
              AnimatedPositioned(
                duration: const Duration(milliseconds: 300),
                curve: Curves.easeInOut,
                bottom: 0,
                left: c.isExpanded ? 0 : 6,
                right: c.isExpanded ? 0 : 6,
                child: const JournalIslandView(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
