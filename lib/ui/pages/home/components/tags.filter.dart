import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:poapin/ui/pages/home/components/view.countries.dart';
import 'package:poapin/ui/pages/home/components/view.layers.dart';
import 'package:poapin/ui/pages/home/components/view.options.dart';
import 'package:poapin/ui/pages/home/components/view.tags.dart';
import 'package:poapin/ui/pages/home/components/wrapper.bottomsheet.dart';
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
                            'Clear ALL',
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

class _FilterTitle extends StatelessWidget {
  final String title;

  const _FilterTitle({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 96,
      height: 56,
      alignment: Alignment.centerRight,
      child: Text(
        title,
        style: GoogleFonts.epilogue(
          color: Colors.black38,
          fontSize: 16,
          fontWeight: FontWeight.bold,
        ),
      ),
      margin: const EdgeInsets.only(left: 8, right: 8),
    );
  }
}

class FilterLine extends StatelessWidget {
  final String title;
  final String content;
  final String hint;
  final Function() onPressed;
  final Function() onClearPressed;

  const FilterLine({
    Key? key,
    required this.title,
    required this.content,
    required this.hint,
    required this.onPressed,
    required this.onClearPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          _FilterTitle(title: title),
          Expanded(
            child: Stack(
              children: [
                RawMaterialButton(
                  onPressed: onPressed,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: content.isEmpty
                        ? Text(
                            hint,
                            style: GoogleFonts.courierPrime(
                              color: Colors.black26,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            content,
                            style: GoogleFonts.courierPrime(
                              color: Colors.orangeAccent.shade400,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                content.isEmpty
                    ? Container()
                    : Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(Icons.cancel,
                              size: 16, color: Colors.blueGrey.shade100),
                          highlightColor: Colors.red.shade200.withOpacity(0.3),
                          splashColor:
                              Colors.redAccent.shade200.withOpacity(0.3),
                          onPressed: onClearPressed,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class FilterInputLine extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function() onEditingComplete;
  final Function() onClearPressed;

  const FilterInputLine({
    Key? key,
    required this.title,
    required this.controller,
    required this.onEditingComplete,
    required this.onClearPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          _FilterTitle(title: title),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  padding: const EdgeInsets.only(
                    right: 16,
                  ),
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: controller,
                    cursorColor: const Color(0xFF6534FF),
                    cursorRadius: const Radius.circular(8),
                    cursorWidth: 2,
                    style: GoogleFonts.courierPrime(
                      color: Colors.orangeAccent.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      border: null,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      hintText: title,
                      hintStyle: GoogleFonts.courierPrime(
                        color: Colors.black26,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // fontSize: 18,
                      ),
                    ),
                    onEditingComplete: onEditingComplete,
                  ),
                ),
                controller.text.isEmpty
                    ? Container()
                    : Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(Icons.cancel,
                              size: 16, color: Colors.blueGrey.shade100),
                          highlightColor: Colors.red.shade200.withOpacity(0.3),
                          splashColor:
                              Colors.redAccent.shade200.withOpacity(0.3),
                          onPressed: onClearPressed,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

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
                    'Filter',
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
              title: 'title',
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
              title: 'description',
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
                title: 'country',
                hint: 'country',
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
                title: 'tag',
                hint: 'tag',
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
                title: 'chain',
                content:
                    c.filters['chain'] == null ? '' : c.filters['chain'] ?? '',
                hint: 'chain',
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

class HintView extends StatelessWidget {
  const HintView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: RawMaterialButton(
              onPressed: () {
                showMaterialModalBottomSheet(
                  expand: false,
                  context: context,
                  duration: const Duration(milliseconds: 100),
                  builder: (context) => const ExpandedHintView(),
                  backgroundColor: Colors.transparent,
                );
              },
              child: Container(
                  height: 56,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Colors.black26,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          'Filter by name, description, location, etc.',
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: GoogleFonts.epilogue(
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterTag extends StatelessWidget {
  final String title;
  final String value;
  final Function() onPressed;
  final Function() onClearPressed;

  const FilterTag({
    Key? key,
    required this.title,
    required this.value,
    required this.onPressed,
    required this.onClearPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          RawMaterialButton(
            onPressed: onPressed,
            padding: const EdgeInsets.only(left: 8, right: 4),
            constraints: const BoxConstraints(minWidth: 16),
            child: Container(
              height: 56,
              padding: const EdgeInsets.symmetric(horizontal: 0),
              child: Row(
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lato(color: Colors.blueGrey),
                  ),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 2),
                    child: Text(
                      ':',
                      style: GoogleFonts.lato(color: Colors.blueGrey),
                    ),
                  ),
                  Text(
                    value,
                    style: GoogleFonts.lato(
                      color: Colors.orangeAccent.shade400,
                    ),
                  ),
                ],
              ),
            ),
          ),
          value.isEmpty
              ? Container()
              : RawMaterialButton(
                  constraints: const BoxConstraints(
                    minWidth: 32,
                    minHeight: 32,
                  ),
                  materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  onPressed: onClearPressed,
                  shape: const CircleBorder(),
                  highlightColor: Colors.red.shade200.withOpacity(0.3),
                  splashColor: Colors.redAccent.shade200.withOpacity(0.3),
                  child: Icon(Icons.cancel,
                      size: 18, color: Colors.blueGrey.shade100),
                ),
        ],
      ),
    );
  }
}
