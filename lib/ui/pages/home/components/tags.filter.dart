import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/pages/home/components/filter/tag.dart';
import 'package:poapin/ui/pages/home/components/filter/view.hint.dart';
import 'package:poapin/ui/pages/home/components/view.options.dart';
import 'package:poapin/ui/pages/home/controller.dart';
import 'package:poapin/ui/pages/home/controller.filter.dart';

class FilterTags extends StatelessWidget {
  const FilterTags({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => SliverAppBar(
        pinned: c.isEditMode,
        floating: true,
        snap: false,
        backgroundColor: Colors.transparent,
        automaticallyImplyLeading: false,
        elevation: 0,
        leading: null,
        stretch: true,
        flexibleSpace: ClipRect(
          child: BackdropFilter(
            filter: ImageFilter.blur(
              sigmaX: 10.0,
              sigmaY: 10.0,
            ),
            child: Container(
              margin: const EdgeInsets.symmetric(horizontal: 16),
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      clipBehavior: Clip.antiAlias,
                      elevation: 16,
                      shape: const RoundedRectangleBorder(
                          side: BorderSide(color: Colors.white70, width: 1),
                          borderRadius: BorderRadius.all(Radius.circular(8))),
                      shadowColor: Colors.black26,
                      child: GetBuilder<HomeController>(builder: (c) {
                        if (c.filters.isEmpty) {
                          return const HintView();
                        } else {
                          return const FiltersView();
                        }
                      }),
                    ),
                  ),
                  Card(
                    clipBehavior: Clip.antiAlias,
                    elevation: 16,
                    shape: const RoundedRectangleBorder(
                        side: BorderSide(color: Colors.white70, width: 1),
                        borderRadius: BorderRadius.all(Radius.circular(8))),
                    shadowColor: Colors.black26,
                    child: Row(
                      children: [
                        SizedBox(
                          width: 48,
                          height: 48,
                          child: RawMaterialButton(
                            elevation: 0,
                            padding: const EdgeInsets.all(0),
                            onPressed: () {
                              if (MediaQuery.of(context).size.width >
                                  (768 + 800)) {
                                Get.find<HomeController>().isWebOption =
                                    !Get.find<HomeController>().isWebOption;

                                Get.find<HomeController>().update();
                                Get.find<HomeController>()
                                    .setIsWebOptionHover(true);
                              } else {
                                showMaterialModalBottomSheet(
                                  expand: false,
                                  context: context,
                                  clipBehavior: Clip.antiAlias,
                                  duration: const Duration(milliseconds: 100),
                                  builder: (context) =>
                                      const OverlayOptionsView(),
                                  backgroundColor: Colors.transparent,
                                );
                              }
                            },
                            child: Container(
                              width: 36,
                              height: 36,
                              alignment: Alignment.center,
                              child: const Icon(
                                Icons.tune,
                                size: 24,
                              ),
                            ),
                          ),
                        ),
                        GetBuilder<HomeController>(
                          builder: (c) => c.isEditMode
                              ? Container()
                              : SizedBox(
                                  width: 48,
                                  height: 48,
                                  child: RawMaterialButton(
                                    elevation: 0,
                                    padding: const EdgeInsets.all(0),
                                    onPressed: () {
                                      HomeController c =
                                          Get.find<HomeController>();
                                      c.setIsEditMode(!c.isEditMode);
                                    },
                                    child: Container(
                                      width: 36,
                                      height: 36,
                                      alignment: Alignment.center,
                                      child: const Icon(
                                        Icons.edit_outlined,
                                        size: 24,
                                      ),
                                    ),
                                  ),
                                ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class FiltersView extends StatelessWidget {
  const FiltersView({Key? key}) : super(key: key);

  List<Widget> _buildFilters(HomeController controller) {
    List<Widget> filters = [];
    if (controller.filters.isNotEmpty) {
      controller.filters.forEach((key, value) {
        filters.add(
          FilterTag(
            title: key,
            value: key == 'tag' ? value.name ?? '' : value,
            onPressed: () {},
            onClearPressed: () {
              if (key == 'title') {
                controller.clearTitleFilter();
                HomeFilterController filterController =
                    Get.find<HomeFilterController>();
                filterController.nameController.text = '';
              }
              if (key == 'description') {
                controller.clearDescFilter();
                HomeFilterController filterController =
                    Get.find<HomeFilterController>();
                filterController.descController.text = '';
              }
              if (key == 'country') {
                controller.clearCountryFilter();
              }
              if (key == 'tag') {
                controller.clearTagFilter();
              }
              if (key == 'chain') {
                controller.clearChainFilter();
              }
            },
          ),
        );
      });
    } else {
      return [Container()];
    }

    return filters;
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<HomeController>(
      builder: (c) => Container(
        height: 56,
        color: Colors.white,
        child: Row(
          children: [
            Expanded(
              child: Container(
                height: 56,
                alignment: Alignment.centerLeft,
                child: Row(children: [
                  Expanded(
                    child: ListView(
                      scrollDirection: Axis.horizontal,
                      children: _buildFilters(c),
                    ),
                  ),
                  Container(
                    width: 1,
                    color: const Color(0x11000000),
                    margin: const EdgeInsets.symmetric(vertical: 2),
                  ),
                  RawMaterialButton(
                    child: Container(
                      height: 56,
                      padding: const EdgeInsets.symmetric(horizontal: 12),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text(
                            strFilterClearAll,
                            style: GoogleFonts.lato(
                              color: Colors.orangeAccent.shade400,
                            ),
                          ),
                        ],
                      ),
                    ),
                    onPressed: () {
                      c.clearFilters();
                      HomeFilterController filterController =
                          Get.find<HomeFilterController>();
                      filterController.clear();
                    },
                  ),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
