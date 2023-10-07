import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive/hive.dart';
import 'package:poapin/common/constants.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/controllers/tag.dart';
import 'package:poapin/data/models/tag.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/util/show_input.dart';

class AddTagDialog extends StatelessWidget {
  final List<Event> events;
  final TextEditingController textEditController;

  const AddTagDialog({
    Key? key,
    required this.events,
    required this.textEditController,
  }) : super(key: key);

  double getHorizontalPadding(context) {
    double width = MediaQuery.of(context).size.width;
    if (width > 480) {
      return (width - 480) / 2 < 24 ? 24 : (width - 480) / 2;
    } else {
      return 24;
    }
  }

  @override
  Widget build(BuildContext context) {
    List buildDivider(TagController c) {
      return c.allTags.isEmpty
          ? []
          : [
              Container(
                margin: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                child: Row(children: [
                  Expanded(
                    child: Container(),
                  ),
                  Container(
                    height: 1,
                    width: 48,
                    margin: const EdgeInsets.only(right: 8),
                    color: Colors.grey[200],
                  ),
                  Text(
                    strEditTagHint,
                    textAlign: TextAlign.center,
                    style: GoogleFonts.lato(
                      color: Colors.black54,
                    ),
                  ),
                  Container(
                    height: 1,
                    width: 48,
                    margin: const EdgeInsets.only(left: 8),
                    color: Colors.grey[200],
                  ),
                  Expanded(
                    child: Container(),
                  ),
                ]),
              )
            ];
    }

    List buildTags(TagController c, List<Event> events) {
      return c.allTags.isEmpty
          ? []
          : c.allTags
              .map(
                (tag) => RawMaterialButton(
                  fillColor: c.getFillColor(tag.id),
                  elevation: 0,
                  onPressed: () {
                    c.selectTag(tag.id, events, (List<Tag> tags) {});
                  },
                  child: SizedBox(
                    height: 56,
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        Icon(
                          Icons.local_offer,
                          color: c.getIconColor(tag.id),
                        ),
                        const SizedBox(width: 16),
                        Expanded(
                          child: Container(
                            alignment: Alignment.centerLeft,
                            child: Text(
                              tag.name,
                              style: GoogleFonts.courierPrime(
                                fontWeight: FontWeight.bold,
                                color: Colors.black87,
                                fontSize: 16,
                              ),
                            ),
                          ),
                        ),
                        const SizedBox(width: 16),
                        const SizedBox(width: 16),
                      ],
                    ),
                  ),
                ),
              )
              .toList();
    }

    return Container(
      alignment: Alignment.center,
      margin: EdgeInsets.symmetric(horizontal: getHorizontalPadding(context)),
      child: Material(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
        child: GetBuilder<TagController>(
          builder: (c) => ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.only(left: 16, top: 24, bottom: 16),
                child: Text.rich(
                  TextSpan(
                      text: 'Edit tags of ',
                      style: GoogleFonts.epilogue(
                          height: 1.6, fontSize: 16, color: Colors.black54),
                      children: [
                        TextSpan(
                          text: events.isNotEmpty ? events[0].name : '-',
                          style: GoogleFonts.epilogue(
                            fontSize: 16,
                            color: Colors.black54,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                        events.length > 1
                            ? TextSpan(
                                text: ' and ${events.length - 1} other events',
                                style: GoogleFonts.epilogue(
                                  fontSize: 16,
                                  color: Colors.black54,
                                ),
                              )
                            : const TextSpan(
                                text: '',
                              ),
                      ]),
                ),
              ),
              ...buildTags(c, events),
              ...buildDivider(c),
              Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 16),
                alignment: Alignment.center,
                child: RawMaterialButton(
                  fillColor: Colors.green.shade50,
                  elevation: 2,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 16),
                    child: Text(
                      strNewTag,
                      style: GoogleFonts.courierPrime(
                        fontWeight: FontWeight.bold,
                        color: Colors.black87,
                      ),
                    ),
                  ),
                  onPressed: () {
                    InputHelper.showBottomInput(
                        context, strNewTagHint, textEditController, () {
                      if (textEditController.text.isNotEmpty) {
                        /// Add tag
                        Box boxTagBox = Hive.box<Tag>(tagBox);
                        bool isSameName = false;
                        for (var tag in boxTagBox.values) {
                          if (tag.name == textEditController.text) {
                            isSameName = true;
                          }
                        }
                        if (isSameName) {
                          return;
                        }

                        Tag newTag = Tag.create(textEditController.text);

                        boxTagBox.put(newTag.id, newTag);

                        /// Add tag to events
                        Box boxEventBox = Hive.box<Event>(eventBox);

                        for (var event in events) {
                          Event event = boxEventBox.get(event.id,
                              defaultValue: Event.empty());

                          List<Tag> tags = event.tags ?? [];
                          tags.add(newTag);
                          event.tags = tags;

                          if (event.id == 0) {
                            boxEventBox.put(event.id, event);
                          } else {
                            boxEventBox.put(event.id, event);
                          }
                        }

                        c.refreshTag(events.map((e) => e.id).toList());
                        Get.back();
                        textEditController.clear();
                      }
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
