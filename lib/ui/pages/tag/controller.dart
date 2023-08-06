import 'dart:io';
import 'dart:typed_data';

import 'package:extended_image/extended_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:path_provider/path_provider.dart';
import 'package:poapin/common/constants.dart';
import 'package:poapin/controllers/tag.dart';
import 'package:poapin/data/models/tag.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:poapin/ui/pages/detail/dialog/addtag.dart';
import 'package:screenshot/screenshot.dart';
import 'package:share_plus/share_plus.dart';

enum Layout {
  masonry,
  tiny,
}

class TagDetailController extends BaseController {
  List<Event> allEvents = [];
  Tag? tag;

  Layout layout = Layout.tiny;
  bool isEditMode = false;
  List<Event> selectedEvents = <Event>[];

  //Create an instance of ScreenshotController
  ScreenshotController screenshotController = ScreenshotController();

  @override
  void onInit() {
    super.onInit();
    final parameters = Get.parameters;
    final arguments = Get.arguments;
    final String tagID = parameters['id'].toString();

    if (arguments != null && arguments is Tag) {
      tag = arguments;
      update();
    }

    getTokensInTag(tagID);
  }

  void setIsEditMode(bool isEditMode) {
    this.isEditMode = isEditMode;
    update();
  }

  void clearSelectedEvents() {
    selectedEvents.clear();
  }

  bool isSelected(Event e) {
    return selectedEvents.contains(e);
  }

  final TextEditingController textEditController = TextEditingController();

  void editTag() {
    List<Event> _events = [];
    for (var e in selectedEvents) {
      if (!_events.contains(e)) {
        _events.add(e);
      }
    }
    Get.find<TagController>().refreshTag(_events.map((e) => e.id).toList());
    Get.dialog(
      AddTagDialog(
        events: _events,
        textEditController: textEditController,
      ),
    );
  }

  void setSelectedEvent(Event e) {
    if (selectedEvents.isEmpty) {
      selectedEvents = [e];
    } else {
      bool alreadySelected = false;
      for (var event in selectedEvents) {
        if (e.id == event.id) {
          alreadySelected = true;
        }
      }
      if (alreadySelected) {
        selectedEvents.remove(e);
      } else {
        selectedEvents.add(e);
      }
    }
    update();
  }

  void toggleLayout() {
    if (layout == Layout.masonry) {
      layout = Layout.tiny;
    } else {
      layout = Layout.masonry;
    }
    update();
  }

  getTokensInTag(String tagID) {
    if (tagID == '') {
      return;
    }
    Box _eventsBox = Hive.box<Event>(eventBox);
    // Box _tokenBox = Hive.box<Token>(poapBox);
    for (Event e in _eventsBox.values.toList()) {
      e.tags?.forEach((tag) {
        if (tag.id == tagID) {
          allEvents.add(e);
        }
      });
    }
    update();
  }

  File? imagePath;
  Uint8List? image;

  void capture(BuildContext context) {
    double contentWidth =
        (Get.width - 64) > 512 ? (512 - 64) : (Get.width - 64);
    double poapSize = contentWidth / 6;
    double contentHeight = poapSize * (allEvents.length / 6).ceil() + 32;
    double imageHeight = ((contentWidth + 32) * 764) / 1280;
    screenshotController
        .captureFromWidget(
      Container(
        width: (Get.width - 32) > 512 ? (512 - 64) : (Get.width - 32),
        color: Colors.white,
        height: 88 + contentHeight + imageHeight,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            tag == null
                ? Container()
                : Container(
                    height: 88,
                    color: Colors.white,
                    width: double.infinity,
                    alignment: Alignment.center,
                    padding: const EdgeInsets.symmetric(horizontal: 16),
                    child: Text(
                      tag!.name,
                      style: GoogleFonts.carterOne(
                        fontSize: 26,
                        color: const Color(0xFF6534FF),
                        shadows: [
                          Shadow(
                              color: Colors.white.withOpacity(0.8),
                              offset: const Offset(1, 1),
                              blurRadius: 2),
                        ],
                      ),
                    )),
            FittedBox(
              fit: BoxFit.scaleDown,
              child: Container(
                width: contentWidth,
                height: contentHeight,
                alignment: Alignment.center,
                padding: const EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: GridView.builder(
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 6,
                    childAspectRatio: 1.0,
                  ),
                  itemCount: allEvents.length,
                  itemBuilder: (context, index) {
                    return Container(
                      padding: const EdgeInsets.all(4),
                      child: Material(
                        elevation: 2,
                        shadowColor: Colors.black,
                        color: Colors.transparent,
                        shape: const CircleBorder(),
                        clipBehavior: Clip.antiAlias,
                        child: ExtendedImage.network(
                          allEvents[index].imageUrl,
                          width: double.infinity,
                          fit: BoxFit.cover,
                          cache: true,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
            Stack(
              children: [
                Container(
                  height: imageHeight,
                  width: double.infinity,
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        Colors.white,
                        Colors.indigo.shade100,
                      ],
                    ),
                  ),
                  child: Image.asset('assets/common/poap_bottom.png'),
                ),
                Positioned(
                    right: 8,
                    bottom: 4,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Learn POAP at poap.xyz',
                              style: GoogleFonts.epilogue(
                                fontSize: 11,
                                color: const Color(0x886534FF),
                                shadows: [
                                  Shadow(
                                      color: Colors.white.withOpacity(0.8),
                                      offset: const Offset(1, 1),
                                      blurRadius: 2),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(height: 4),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Text(
                              'Organized by ',
                              style: GoogleFonts.epilogue(
                                fontSize: 11,
                                color: const Color(0x886534FF),
                                shadows: [
                                  Shadow(
                                      color: Colors.white.withOpacity(0.8),
                                      offset: const Offset(1, 1),
                                      blurRadius: 2),
                                ],
                              ),
                            ),
                            Text(
                              'POAP.in',
                              style: GoogleFonts.carterOne(
                                fontSize: 10,
                                color: const Color(0x886534FF),
                                shadows: [
                                  Shadow(
                                      color: Colors.white.withOpacity(0.8),
                                      offset: const Offset(1, 1),
                                      blurRadius: 2),
                                ],
                              ),
                            ),
                          ],
                        )
                      ],
                    )),
              ],
            ),
          ],
        ),
      ),
      delay: const Duration(milliseconds: 10),
      pixelRatio: MediaQuery.of(context).devicePixelRatio,
    )
        .then((image) async {
      Get.dialog(Container(
        margin: const EdgeInsets.all(16),
        alignment: Alignment.center,
        child: Column(
          children: [
            Expanded(
              child: Image.memory(image),
            ),
            Container(
              margin: const EdgeInsets.only(top: 32),
              child:
                  Row(mainAxisAlignment: MainAxisAlignment.center, children: [
                RawMaterialButton(
                  onPressed: () async {
                    Get.back();

                    await imagePath!.writeAsBytes(image);

                    await Share.shareXFiles(
                        [XFile(imagePath!.path, mimeType: 'image/png')]);
                  },
                  shape: const RoundedRectangleBorder(
                      borderRadius: BorderRadius.all(Radius.circular(16))),
                  fillColor: Colors.white,
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                      vertical: 16,
                      horizontal: 24,
                    ),
                    child: Text(
                      'Share',
                      style: GoogleFonts.lato(
                        fontSize: 24,
                        color: const Color(0x886534FF),
                        shadows: [
                          Shadow(
                              color: Colors.white.withOpacity(0.8),
                              offset: const Offset(1, 1),
                              blurRadius: 2),
                        ],
                      ),
                    ),
                  ),
                ),
              ]),
            ),
          ],
        ),
      ));

      final directory = await getApplicationDocumentsDirectory();
      imagePath = await File('${directory.path}/image.png').create();
      this.image = image;
    });
  }

  @override
  String screenName() {
    return 'Tag Detail';
  }
}
