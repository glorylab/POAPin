import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/pages/home/components/filter/line.dart';
import 'package:poapin/ui/pages/home/components/filter/line.input.dart';
import 'package:poapin/ui/pages/home/components/view.countries.dart';
import 'package:poapin/ui/pages/home/components/view.layers.dart';
import 'package:poapin/ui/pages/home/components/view.tags.dart';
import 'package:poapin/ui/pages/home/components/wrapper.bottomsheet.dart';
import 'package:poapin/ui/pages/home/controller.dart';
import 'package:poapin/ui/pages/home/controller.filter.dart';

class ExpandedHintView extends StatelessWidget {
  const ExpandedHintView({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    HomeFilterController filterController = Get.find<HomeFilterController>();
    HomeController collectionController = Get.find<HomeController>();
    return BottomSheetWrapper(
      content: FocusScope(
        node: filterController.focusNode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 48,
              child: RawMaterialButton(
                onPressed: null,
                child: Row(children: [
                  const SizedBox(
                    width: 16,
                  ),
                  Text(
                    strFilter,
                    style: GoogleFonts.epilogue(
                        fontSize: 16, color: Colors.black54),
                  ),
                  Expanded(
                    child: Container(),
                  ),
                  const SizedBox(
                    width: 16,
                  ),
                ]),
              ),
            ),
            const SizedBox(height: 8),
            FilterInputLine(
              title: strFilterTitle,
              controller: filterController.nameController,
              onEditingComplete: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                collectionController
                    .setFilterByTitle(filterController.nameController.text);
              },
              onClearPressed: () {
                collectionController.clearTitleFilter();
                filterController.nameController.clear();
              },
            ),
            FilterInputLine(
              title: strFilterDescription,
              controller: filterController.descController,
              onEditingComplete: () {
                FocusScopeNode currentFocus = FocusScope.of(context);

                if (!currentFocus.hasPrimaryFocus) {
                  currentFocus.unfocus();
                }
                collectionController
                    .setFilterByDesc(filterController.descController.text);
              },
              onClearPressed: () {
                collectionController.clearDescFilter();
                filterController.descController.clear();
              },
            ),
            GetBuilder<HomeController>(
              builder: (c) => FilterLine(
                title: strFilterCountry,
                hint: strFilterCountry,
                content: c.filters['country'] ?? '',
                onPressed: () {
                  showMaterialModalBottomSheet(
                    expand: false,
                    context: context,
                    clipBehavior: Clip.antiAlias,
                    duration: const Duration(milliseconds: 100),
                    builder: (context) => const CountriesView(),
                    backgroundColor: Colors.transparent,
                  );
                },
                onClearPressed: () {
                  collectionController.clearCountryFilter();
                },
              ),
            ),
            GetBuilder<HomeController>(
              builder: (c) => FilterLine(
                title: strFilterTag,
                hint: strFilterTag,
                content:
                    c.filters['tag'] == null ? '' : c.filters['tag'].name ?? '',
                onPressed: () {
                  Get.find<HomeController>().filter();
                  // todo refresh tags
                  showMaterialModalBottomSheet(
                    expand: false,
                    context: context,
                    duration: const Duration(milliseconds: 100),
                    builder: (context) => const TagsView(),
                    backgroundColor: Colors.transparent,
                  );
                },
                onClearPressed: () {
                  collectionController.clearTagFilter();
                },
              ),
            ),
            GetBuilder<HomeController>(
              builder: (c) => FilterLine(
                title: strFilterChain,
                content:
                    c.filters['chain'] == null ? '' : c.filters['chain'] ?? '',
                hint: strFilterChain,
                onClearPressed: () {
                  collectionController.clearChainFilter();
                },
                onPressed: () {
                  showMaterialModalBottomSheet(
                    expand: false,
                    context: context,
                    duration: const Duration(milliseconds: 100),
                    builder: (context) => const LayersView(),
                    backgroundColor: Colors.transparent,
                  );
                },
              ),
            ),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
