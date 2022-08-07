import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/dashboard/controller.dart';
import 'package:poapin/ui/pages/home/page.dart';
import 'package:poapin/ui/pages/me/page.dart';
import 'package:poapin/ui/pages/watchlist/page.dart';

class DashboardPage extends GetView<DashboardController> {
  const DashboardPage({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          !kIsWeb
              ? Container()
              : GetBuilder<DashboardController>(
                  builder: (c) => c.isNoticeRead
                      ? Container()
                      : Container(
                          padding: EdgeInsets.only(
                            top: MediaQuery.of(context).padding.top,
                          ),
                          color: PColor.background,
                          child: SizedBox(
                            height: 56,
                            child: Card(
                              clipBehavior: Clip.antiAlias,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(children: [
                                Expanded(
                                  child: RawMaterialButton(
                                    onPressed: () {
                                      Get.toNamed('/app');
                                    },
                                    child: Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 16,
                                        vertical: 16,
                                      ),
                                      child: Text(
                                        'Get a smoother experience with mobile app.',
                                        style: GoogleFonts.lato(
                                          fontSize: 14,
                                          letterSpacing: 1,
                                          color: Theme.of(context)
                                              .primaryColorDark,
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                IconButton(
                                    onPressed: () {
                                      c.markAsRead();
                                    },
                                    icon: const Icon(
                                      Icons.cancel_outlined,
                                      color: Colors.black12,
                                    )),
                              ]),
                            ),
                          ),
                        ),
                ),
          Expanded(
            child: Obx(
              () => IndexedStack(
                index: controller.tabIndex.value,
                children: const [
                  HomePage(),
                  WatchlistPage(),
                  // SquarePage(),
                  MePage(),
                ],
              ),
            ),
          ),
        ],
      ),
      bottomNavigationBar: Obx(
        () => BottomNavigationBar(
          onTap: controller.changeTabIndex,
          currentIndex: controller.tabIndex.value,
          elevation: 24,
          backgroundColor: Colors.white,
          selectedItemColor: Theme.of(context).primaryColorDark,
          unselectedItemColor: Theme.of(context).toggleableActiveColor,
          type: BottomNavigationBarType.fixed,
          showUnselectedLabels: true,
          landscapeLayout: BottomNavigationBarLandscapeLayout.centered,
          items: const [
            BottomNavigationBarItem(
              icon: Icon(Icons.cottage_outlined),
              label: 'Home',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.collections_bookmark_outlined),
              label: 'Watchlist',
              backgroundColor: Colors.white,
            ),
            BottomNavigationBarItem(
              icon: Icon(Icons.account_circle_outlined),
              label: 'Me',
              backgroundColor: Colors.white,
            ),
          ],
        ),
      ),
    );
  }
}
