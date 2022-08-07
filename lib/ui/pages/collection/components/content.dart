import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/status.dart';
import 'package:poapin/ui/components/alerts/error.dart';
import 'package:poapin/ui/components/buttons/back.dart';
import 'package:poapin/ui/components/buttons/go_home.dart';
import 'package:poapin/ui/components/loading.dart';
import 'package:poapin/ui/pages/collection/components/view.month.dart';
import 'package:poapin/ui/pages/collection/components/view.options.dart';
import 'package:poapin/ui/pages/collection/controller.dart';
import 'package:poapin/ui/pages/collection/controller.filter.dart';

class CollectionContent extends StatelessWidget {
  const CollectionContent({Key? key, required this.horizontalPadding})
      : super(key: key);
  final double horizontalPadding;

  List<Widget> _getContent(CollectionController controller) {
    List<Widget> yearWrappers = [];

    /// Get all years
    controller.filteredTokens.value.forEach((year, tokensOfMonth) {
      for (var entry in tokensOfMonth.entries) {
        yearWrappers.add(
          MonthView(tokens: entry.value, year: year, month: entry.key),
        );
      }
    });
    return yearWrappers;
  }

  @override
  Widget build(BuildContext context) {
    Get.put(FilterController());
    return Scaffold(
      appBar: AppBar(
        leading: Get.previousRoute == ''
            ? const GoHomeButton()
            : const GoBackButton(),
        title: GetBuilder<CollectionController>(
          builder: (c) => Row(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Expanded(
                child: Container(
                  height: 56,
                  alignment: Alignment.centerLeft,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      c.ensAddress.isNotEmpty
                          ? Container(
                              padding: const EdgeInsets.only(bottom: 8),
                              child: Text(
                                c.ensAddress,
                                style: GoogleFonts.courierPrime(
                                  color: Colors.black87,
                                  fontSize: 18,
                                ),
                              ),
                            )
                          : Container(),
                      Text(
                        c.ethAddress,
                        style: GoogleFonts.shareTechMono(
                          color: c.ensAddress.isNotEmpty
                              ? Colors.black26
                              : Colors.black87,
                          fontSize: c.ensAddress.isNotEmpty ? 12 : 18,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              (((c.cacheLoadingStatus == CacheLoadingStatus.loaded) ||
                      (c.loadingStatus == LoadingStatus.loaded)))
                  ? OutlinedButton(
                      onPressed: () {
                        c.toogleFavorite();
                      },
                      child: !c.isFavorite
                          ? Text(
                              '+ Follow',
                              style: GoogleFonts.roboto(
                                  color: Theme.of(context).primaryColorDark),
                            )
                          : Text(
                              'Unfollow',
                              style: GoogleFonts.roboto(color: Colors.blueGrey),
                            ),
                    )
                  : Container(),
            ],
          ),
        ),
        actions: [
          GetBuilder<CollectionController>(
            builder: (c) =>
                ((c.cacheLoadingStatus == CacheLoadingStatus.loaded &&
                            c.count.value > 0) ||
                        (c.loadingStatus == LoadingStatus.loaded &&
                            c.count.value > 0))
                    ? IconButton(
                        onPressed: () {
                          Get.bottomSheet(const OptionsView());
                        },
                        icon: const Icon(
                          Icons.tune,
                        ),
                      )
                    : Container(),
          ),
        ],
      ),
      body: GetBuilder<CollectionController>(
        builder: (c) {
          /// loading status
          if (c.cacheLoadingStatus == CacheLoadingStatus.loading ||
              ((c.loadingStatus == LoadingStatus.loading) &&
                  c.count.value == 0)) {
            return const Center(
              child: LoadingAnimation(),
            );
          }

          /// loadedStatus
          if ((c.cacheLoadingStatus == CacheLoadingStatus.loaded ||
              c.loadingStatus == LoadingStatus.loaded)) {
            return CustomScrollView(
              keyboardDismissBehavior: ScrollViewKeyboardDismissBehavior.onDrag,
              slivers: [
                _getContent(c),
              ].expand((element) => element).toList(),
            );
          } else

          /// error
          {
            return Center(
              child: ErrorBoard(
                text: c.error.value,
              ),
            );
          }
        },
      ),
    );
  }
}
