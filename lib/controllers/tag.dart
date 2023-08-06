import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:hive/hive.dart';
import 'package:poapin/common/constants.dart';
import 'package:poapin/data/models/tag.dart';
import 'package:poapin/data/models/token.dart';

enum TagStatus { allChecked, someChecked, noneChecked }

class TagController extends GetxController {
  Map<int, List<Tag>> tagsInEvents = {};
  Map<int, List<String>> tagIDsInEvents = {};
  List<Tag> allTags = <Tag>[];

  List<Tag> getTagsInEvent(int eventID) {
    return tagsInEvents[eventID] ?? [];
  }

  selectTag(String tagID, List<Event> events, callback) {
    Box boxTagBox = Hive.box<Tag>(tagBox);

    TagStatus status = checkStatus(tagID);
    for (var t in boxTagBox.values.toList()) {
      if ((t as Tag).id == tagID) {
        Box boxEventBox = Hive.box<Event>(eventBox);
        List<int> eventIDs = [];
        for (var e in events) {
          eventIDs.add(e.id);

          List<Tag> selectedTags = boxEventBox.get(e.id)?.tags ?? [];

          /// if tag is empty, add tag
          if (selectedTags.isEmpty) {
            selectedTags.add(t);
          } else {
            bool isSelected = false;
            for (var t in selectedTags) {
              if (t.id == tagID) {
                isSelected = true;
              }
            }

            if (isSelected) {
              /// if tag is selected, remove it
              selectedTags.removeWhere((t) => t.id == tagID);
            } else {
              if (status == TagStatus.someChecked) {
                selectedTags.removeWhere((t) => t.id == tagID);
              } else {
                /// if tag is not selected, add it
                selectedTags.add(t);
              }
            }
          }

          e.tags = selectedTags;

          boxEventBox.put(e.id, e);
        }
        refreshTag(eventIDs);
      }
    }
  }

  TagStatus checkStatus(String tagID) {
    int count = 0;

    tagIDsInEvents.forEach((eventID, tags) {
      if (tags.contains(tagID)) {
        count++;
      }
    });

    return count == 0
        ? TagStatus.noneChecked
        : count == tagIDsInEvents.length
            ? TagStatus.allChecked
            : TagStatus.someChecked;
  }

  Color getFillColor(String tagID) {
    TagStatus status = checkStatus(tagID);
    switch (status) {
      case TagStatus.allChecked:
        return Colors.green.shade50;
      case TagStatus.someChecked:
        return Colors.yellow.shade50;
      case TagStatus.noneChecked:
        return Colors.white;
      default:
        return Colors.white;
    }
  }

  Color getIconColor(String tagID) {
    TagStatus status = checkStatus(tagID);
    switch (status) {
      case TagStatus.allChecked:
        return Colors.green;
      case TagStatus.someChecked:
        return Colors.yellow;
      case TagStatus.noneChecked:
        return Colors.grey;
      default:
        return Colors.grey;
    }
  }

  void refreshTag(List<int> eventIDs) {
    tagIDsInEvents.clear();
    tagIDsInEvents.clear();
    Box boxEventBox = Hive.box<Event>(eventBox);

    for (var eventID in eventIDs) {
      List<Tag> tagsInEvent = boxEventBox.get(eventID)?.tags ?? [];
      tagsInEvents[eventID] = tagsInEvent;
      tagIDsInEvents[eventID] = tagsInEvent.map((t) => t.id).toList();
    }

    Box boxTagBox = Hive.box<Tag>(tagBox);
    allTags = boxTagBox.values.map((tag) => tag as Tag).toList();
    update();
  }
}
