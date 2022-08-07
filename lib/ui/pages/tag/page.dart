import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/components/buttons/back.dart';
import 'package:poapin/ui/components/buttons/go_home.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/tag/controller.dart';
import 'package:screenshot/screenshot.dart';

class TagPage extends BasePage<TagDetailController> {
  const TagPage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  double getPadding(double width) {
    if (getCrossAxisCount(width) == 6) {
      return (width - 1200) / 2;
    }
    return 16;
  }

  int getCrossAxisCount(double width) {
    if (controller.allEvents.length > 4) {
      if (width > 1100) {
        return 6;
      } else if (width > 900) {
        return 5;
      } else if (width > 700) {
        return 4;
      } else if (width > 500) {
        return 3;
      } else if (width > 300) {
        return 2;
      } else {
        return 1;
      }
    } else {
      if (width > 300) {
        return 4;
      } else {
        return 4;
      }
    }
  }

  int getTinyCrossAxisCount(double width) {
    if (controller.allEvents.length > 4) {
      if (width > 1100) {
        return 12;
      } else if (width > 1000) {
        return 11;
      } else if (width > 900) {
        return 10;
      } else if (width > 800) {
        return 9;
      } else if (width > 700) {
        return 8;
      } else if (width > 600) {
        return 7;
      } else if (width > 500) {
        return 6;
      } else if (width > 400) {
        return 5;
      } else if (width > 300) {
        return 4;
      } else if (width > 200) {
        return 3;
      } else if (width > 100) {
        return 2;
      } else {
        return 1;
      }
    } else {
      if (width > 300) {
        return 4;
      } else {
        return 4;
      }
    }
  }

  @override
  Widget getPage(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Screenshot(
      controller: controller.screenshotController,
      child: Scaffold(
        appBar: AppBar(
          leading: Get.previousRoute == ''
              ? const GoHomeButton()
              : const GoBackButton(),
          elevation: 2,
          title: GetBuilder<TagDetailController>(
            builder: (c) => Text(
              c.isEditMode
                  ? 'Edit events'
                  : controller.tag != null && controller.tag!.id.isNotEmpty
                      ? 'Tag: ${controller.tag?.name}'
                      : 'Tag',
              overflow: TextOverflow.fade,
              style: GoogleFonts.carterOne(
                color: const Color(0xFF6534FF),
                shadows: [
                  Shadow(
                      color: Colors.white.withOpacity(0.8),
                      offset: const Offset(1, 1),
                      blurRadius: 2),
                ],
              ),
            ),
          ),
          actions: [
            GetBuilder<TagDetailController>(
              builder: (c) {
                if (c.allEvents.isEmpty) {
                  return Container();
                }
                if (!c.isEditMode && c.layout == Layout.tiny) {
                  return IconButton(
                    icon: const Icon(Icons.edit_outlined),
                    onPressed: () {
                      c.setIsEditMode(true);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            GetBuilder<TagDetailController>(
              builder: (c) {
                if (GetPlatform.isWeb) {
                  return Container();
                }
                if (c.isEditMode) {
                  return Container();
                }
                if (c.allEvents.isEmpty) {
                  return Container();
                }
                if (c.layout == Layout.tiny) {
                  return IconButton(
                    icon: const Icon(Icons.share),
                    onPressed: () async {
                      c.capture(context);
                    },
                  );
                } else {
                  return Container();
                }
              },
            ),
            GetBuilder<TagDetailController>(
              builder: (c) {
                if (c.isEditMode) {
                  return Container();
                }
                if (c.allEvents.isEmpty) {
                  return Container();
                }
                return IconButton(
                  icon: c.layout == Layout.masonry
                      ? Image.asset(
                          'assets/common/ic_tiny.png',
                          color: Colors.orangeAccent.shade400,
                        )
                      : Image.asset(
                          'assets/common/ic_kanban.png',
                          color: Colors.orangeAccent.shade400,
                        ),
                  onPressed: () {
                    c.toggleLayout();
                  },
                );
              },
            ),
            GetBuilder<TagDetailController>(
              builder: (c) {
                if (c.allEvents.isEmpty) {
                  return Container();
                }
                return c.isEditMode
                    ? RawMaterialButton(
                        onPressed: () {
                          c.clearSelectedEvents();
                          c.setIsEditMode(false);
                        },
                        child: Row(
                          children: [
                            Text(
                              'Done',
                              style: GoogleFonts.epilogue(
                                color: Theme.of(context).primaryColor,
                                fontSize: 16,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ],
                        ))
                    : Container();
              },
            ),
          ],
        ),
        backgroundColor: Colors.white,
        floatingActionButton: GetBuilder<TagDetailController>(
            builder: (c) => c.isEditMode && c.selectedEvents.isNotEmpty
                ? FloatingActionButton.extended(
                    onPressed: () {
                      c.editTag();
                    },
                    label: const Text('Edit tags'))
                : Container()),
        floatingActionButtonLocation: FloatingActionButtonLocation.endFloat,
        body: Container(
          alignment: Alignment.center,
          child: GetBuilder<TagDetailController>(
            builder: (c) {
              if (controller.allEvents.isEmpty) {
                return Container(
                  alignment: Alignment.center,
                  padding: EdgeInsets.symmetric(
                      horizontal: getHorizontalPadding(context)),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 56,
                      ),
                      Text(
                        'Empty',
                        style: GoogleFonts.epilogue(
                          fontSize: 26,
                          fontWeight: FontWeight.bold,
                          color: Colors.black26,
                        ),
                      ),
                      const SizedBox(
                        height: 16,
                      ),
                      Text(
                        'No events have been grouped under this tag',
                        style: GoogleFonts.lato(
                          fontSize: 20,
                          color: Colors.black54,
                        ),
                      ),
                    ],
                  ),
                );
              }
              if (c.layout == Layout.tiny) {
                return Container(
                  padding: EdgeInsets.symmetric(
                    horizontal: getPadding(width),
                  ),
                  child: GridView.builder(
                    gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisCount: getTinyCrossAxisCount(width),
                      childAspectRatio: 1.0,
                    ),
                    itemCount: c.allEvents.length,
                    itemBuilder: (context, index) {
                      return InkWell(
                        onLongPress: () {
                          if (!c.isEditMode) {
                            c.setIsEditMode(true);
                            c.setSelectedEvent(c.allEvents[index]);
                          }
                        },
                        onTap: () async {
                          if (c.isEditMode) {
                            c.setSelectedEvent(c.allEvents[index]);
                          } else {}
                        },
                        child: Stack(
                          children: [
                            Container(
                              padding: const EdgeInsets.all(8),
                              child: Material(
                                elevation: 4,
                                shadowColor: Colors.black,
                                color: Colors.transparent,
                                shape: const CircleBorder(),
                                clipBehavior: Clip.antiAlias,
                                child: ExtendedImage.network(
                                  c.allEvents[index].imageUrl,
                                  width: double.infinity,
                                  fit: BoxFit.cover,
                                  cache: true,
                                ),
                              ),
                            ),
                            c.isEditMode
                                ? c.isSelected(c.allEvents[index])
                                    ? Container(
                                        color: Colors.green.withOpacity(0.5),
                                        alignment: Alignment.center,
                                        child: const Icon(
                                          Icons.check,
                                          color: Colors.white,
                                          size: 36,
                                        ),
                                      )
                                    : Container()
                                : Container()
                          ],
                        ),
                      );
                    },
                  ),
                );
              }
              return MasonryGridView.count(
                crossAxisCount: getCrossAxisCount(width),
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                addAutomaticKeepAlives: true,
                cacheExtent: 100000,
                padding: EdgeInsets.symmetric(
                    horizontal: getPadding(width), vertical: 32),
                itemCount: c.allEvents.length,
                itemBuilder: (context, index) {
                  return Card(
                    elevation: 8,
                    shadowColor: Colors.blueGrey.withOpacity(0.2),
                    clipBehavior: Clip.antiAlias,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: SizedBox(
                      width: 100,
                      child: Column(
                        children: [
                          ExtendedImage.network(
                            c.allEvents[index].imageUrl,
                            width: double.infinity,
                            fit: BoxFit.cover,
                            cache: true,
                          ),
                          const SizedBox(height: 8),
                          Container(
                            padding: const EdgeInsets.only(
                                top: 4, left: 8, right: 8),
                            child: Text(
                              c.allEvents[index].name,
                              softWrap: true,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.lato(
                                fontSize: 15,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          Container(
                            padding: const EdgeInsets.only(
                                bottom: 4, top: 4, left: 8, right: 8),
                            child: Text(
                              c.allEvents[index].description,
                              textAlign: TextAlign.start,
                              style: GoogleFonts.lato(
                                fontSize: 13,
                                color: Colors.black38,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 16,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              );
            },
          ),
        ),
      ),
    );
  }
}
