import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/data/models/holder.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/components/loading.dart';
import 'package:poapin/ui/pages/event/controller.dart';
import 'package:pull_to_refresh_flutter3/pull_to_refresh_flutter3.dart';

class HoldersInEventPage extends StatelessWidget {
  const HoldersInEventPage({Key? key}) : super(key: key);

  Widget _buildHolderCard(Holder holder, BuildContext context) {
    return Row(
      children: [
        Container(
          height: 40,
          width: 80,
          alignment: Alignment.centerRight,
          decoration: BoxDecoration(
            color: PColor.background,
            borderRadius: BorderRadius.circular(20),
          ),
          child: Text(
            holder.created.substring(0, 10),
            maxLines: 1,
            style: GoogleFonts.robotoCondensed(
              color: Colors.blueGrey.shade300,
              fontSize: 12,
            ),
          ),
        ),
        const SizedBox(width: 8),
        Expanded(
          child: Card(
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            shadowColor: Colors.black26,
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
              child: GetBuilder<EventDetailController>(
                builder: (c) => Row(
                  children: [
                    Expanded(
                      child: Text(
                        c.getHolderName(holder),
                        style: GoogleFonts.robotoMono(
                          color: Colors.indigo.shade500,
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                    ),
                    NumberIndicator(
                      number: holder.transferCount,
                      color: Colors.purple.shade200,
                      icon: Icons.swap_horiz,
                    ),
                    NumberIndicator(
                      number: holder.owner.tokensOwned.toString(),
                      color: Colors.orangeAccent.shade700,
                      icon: Icons.flash_on,
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    double safePaddingLeft = MediaQuery.of(context).padding.left;
    double safePaddingRight = MediaQuery.of(context).padding.right;
    return Container(
      color: PColor.background,
      width: double.infinity,
      height: double.infinity,
      padding: EdgeInsets.only(
          top: MediaQuery.of(context).padding.top,
          left: 0,
          right: 0,
          bottom: 0),
      child: GetBuilder<EventDetailController>(
        builder: (c) => c.isLoadingAllMoments
            ? ListView(
                children: const [
                  SizedBox(height: 256 + 32),
                  LoadingAnimation(),
                ],
              )
            : SmartRefresher(
                enablePullDown: false,
                enablePullUp: true,
                footer: CustomFooter(
                  builder: (BuildContext context, LoadStatus? mode) {
                    Widget body;
                    if (mode == LoadStatus.idle) {
                      body = Text("pull up to load",
                          style: TextStyle(color: Colors.grey[400]));
                    } else if (mode == LoadStatus.noMore) {
                      body = Text("All holders loaded",
                          style: TextStyle(color: Colors.grey[400]));
                    } else if (mode == LoadStatus.loading) {
                      body = const CupertinoActivityIndicator();
                    } else if (mode == LoadStatus.failed) {
                      body = Text("Load Failed! Tap to retry!",
                          style: TextStyle(color: Colors.grey[400]));
                    } else if (mode == LoadStatus.canLoading) {
                      body = Text("release to load more",
                          style: TextStyle(color: Colors.grey[400]));
                    } else {
                      body = Text("No more Data",
                          style: TextStyle(color: Colors.grey[400]));
                    }
                    return SizedBox(
                      height: 55.0,
                      child: Center(child: body),
                    );
                  },
                ),
                controller: c.refreshHoldersController,
                onLoading: c.onHoldersLoading,
                child: CustomScrollView(
                  slivers: [
                    SliverToBoxAdapter(
                      child: Container(
                        height: 256 + 32,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.bottomCenter,
                                end: Alignment.topCenter,
                                stops: const [0.0, 1.0],
                                colors: [PColor.background, Colors.white])),
                      ),
                    ),
                    SliverPadding(
                      padding: EdgeInsets.only(
                        left: 16 + safePaddingLeft,
                        right: 16 + safePaddingRight,
                        top: 12,
                        bottom: 12,
                      ),
                      sliver: SliverList(
                          delegate: SliverChildBuilderDelegate(
                        (context, index) {
                          return _buildHolderCard(c.holders[index], context);
                        },
                        childCount: c.holders.length,
                      )),
                    ),
                  ],
                ),
              ),
      ),
    );
  }
}

class NumberIndicator extends StatelessWidget {
  const NumberIndicator({
    Key? key,
    required this.number,
    required this.color,
    required this.icon,
  }) : super(key: key);

  final String number;
  final Color color;
  final IconData icon;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 24,
      height: 32,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            icon,
            color: color,
            size: 12,
          ),
          Text(
            number,
            style: GoogleFonts.robotoMono(
              color: color,
              fontSize: 10,
              fontWeight: FontWeight.w600,
            ),
          ),
        ],
      ),
    );
  }
}
