import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/collection/components/view.countries.dart';
import 'package:poapin/ui/pages/collection/controller.dart';
import 'package:poapin/ui/pages/collection/controller.filter.dart';

class FilterTags extends StatelessWidget {
  final Map controllerFilters;
  const FilterTags({Key? key, required this.controllerFilters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double getHorizontalPadding() {
      if (width > 768) {
        return (width - 768) / 2;
      } else {
        return 12;
      }
    }

    FilterController filterController = Get.find<FilterController>();
    return Obx((() => SliverAppBar(
          pinned: false,
          floating: true,
          snap: false,
          backgroundColor: PColor.background,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: null,
          stretch: true,
          toolbarHeight: filterController.expanded.value ? 256 - 48 : 56,
          expandedHeight: filterController.expanded.value ? 256 - 48 : 56,
          flexibleSpace: Container(
              margin: EdgeInsets.symmetric(horizontal: getHorizontalPadding()),
              child: Card(
                clipBehavior: Clip.antiAlias,
                elevation: 16,
                shape: const RoundedRectangleBorder(
                    side: BorderSide(color: Colors.white70, width: 1),
                    borderRadius: BorderRadius.all(Radius.circular(8))),
                shadowColor: Colors.black26,
                child: filterController.expanded.value
                    ? ExpandedHintView(
                        controllerFilters: controllerFilters,
                      )
                    : controllerFilters.isEmpty
                        ? const HintView()
                        : FiltersView(
                            controllerFilters: controllerFilters,
                          ),
              )),
        )));
  }
}

class FiltersView extends StatelessWidget {
  const FiltersView({Key? key, required this.controllerFilters})
      : super(key: key);
  final Map controllerFilters;

  List<Widget> _buildFilters(CollectionController controller) {
    List<Widget> filters = [];
    if (controllerFilters.isNotEmpty) {
      controllerFilters.forEach((key, value) {
        filters.add(
          FilterTag(
            title: key,
            value: value,
            onPressed: () {
              FilterController filterController = Get.find<FilterController>();
              filterController.expand();
            },
            onClearPressed: () {
              if (key == 'title') {
                controller.clearTitleFilter();
                FilterController filterController =
                    Get.find<FilterController>();
                filterController.nameController.text = '';
              }
              if (key == 'description') {
                controller.clearDescFilter();
                FilterController filterController =
                    Get.find<FilterController>();
                filterController.descController.text = '';
              }
              if (key == 'country') {
                controller.clearCountryFilter();
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
    CollectionController controller = Get.find<CollectionController>();
    return Container(
      height: 56,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: Container(
              height: 56,
              alignment: Alignment.centerLeft,
              padding: const EdgeInsets.symmetric(),
              child: Row(children: [
                Expanded(
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: _buildFilters(controller),
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
                    controller.clearFilters();
                    FilterController filterController =
                        Get.find<FilterController>();
                    filterController.clear();
                  },
                ),
              ]),
            ),
          ),
        ],
      ),
    );
  }
}

class FilterLine extends StatelessWidget {
  final String title;
  final String content;
  final Function() onPressed;
  final Function() onClearPressed;

  const FilterLine({
    Key? key,
    required this.title,
    required this.content,
    required this.onPressed,
    required this.onClearPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          Container(
            width: 88,
            height: 56,
            alignment: Alignment.centerRight,
            child: Text(
              title,
              style: GoogleFonts.epilogue(
                color: Colors.black54,
              ),
            ),
            margin: const EdgeInsets.only(left: 8, right: 8),
          ),
          Expanded(
            child: Stack(
              children: [
                RawMaterialButton(
                  onPressed: onPressed,
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: content.isEmpty
                        ? Text(
                            'country',
                            style: GoogleFonts.courierPrime(
                              color: Colors.black26,
                            ),
                          )
                        : Text(
                            content,
                            style: GoogleFonts.courierPrime(
                              color: Colors.orangeAccent.shade400,
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
          Container(
            width: 88,
            height: 56,
            alignment: Alignment.centerRight,
            child: Text(
              title,
              style: GoogleFonts.epilogue(
                color: Colors.black54,
              ),
            ),
            margin: const EdgeInsets.only(left: 8, right: 8),
          ),
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
  final Map controllerFilters;
  const ExpandedHintView({Key? key, required this.controllerFilters})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    FilterController filterController = Get.find<FilterController>();
    CollectionController collectionController =
        Get.find<CollectionController>();
    return SizedBox(
      height: 248 - 48,
      child: FocusScope(
        node: filterController.focusNode,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: 48,
              child: RawMaterialButton(
                onPressed: () {
                  filterController.close();
                },
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
                  const Icon(Icons.expand_less, color: Colors.black54),
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
            FilterLine(
              title: strFilterCountry,
              content: controllerFilters['country'] ?? '',
              onPressed: () {
                Get.bottomSheet(
                  const CountriesView(),
                  barrierColor: Colors.deepPurple.withOpacity(0.1),
                );
              },
              onClearPressed: () {
                collectionController.clearCountryFilter();
              },
            ),
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
    FilterController controller = Get.find<FilterController>();
    return Container(
      height: 56,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: RawMaterialButton(
              onPressed: () {
                controller.expand();
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
                          strFilterHint,
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
          RawMaterialButton(
            constraints: const BoxConstraints(
              minWidth: 32,
              minHeight: 32,
            ),
            materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
            onPressed: onClearPressed,
            shape: const CircleBorder(),
            highlightColor: Colors.red.shade200.withOpacity(0.3),
            splashColor: Colors.redAccent.shade200.withOpacity(0.3),
            child:
                Icon(Icons.cancel, size: 18, color: Colors.blueGrey.shade100),
          ),
        ],
      ),
    );
  }
}
