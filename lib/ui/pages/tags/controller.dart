import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:hive/hive.dart';
import 'package:poapin/data/models/tag.dart';
import 'package:poapin/data/models/token.dart';
import 'package:poapin/ui/controller.base.dart';

class TagsController extends BaseController {
  List<Tag> allTags = [];
  @override
  void onInit() {
    super.onInit();
    getAllTags();
  }

  getAllTags() {
    allTags = <Tag>[];
    Box tagBox = Hive.box<Tag>(tagBox);
    for (var t in tagBox.values.toList()) {
      allTags.add(t);
    }
    update();
  }

  deleteTag(Tag tag) {
    Get.dialog(
      AlertDialog(
        title: Text('Delete Tag ${tag.name}'),
        content: const Text('Are you sure you want to delete this tag?'),
        actions: <Widget>[
          RawMaterialButton(
            child: const Text('Cancel'),
            onPressed: () {
              Get.back();
            },
          ),
          RawMaterialButton(
            child: const Text('Delete'),
            onPressed: () {
              Box eventBox = Hive.box<Event>(eventBox);
              for (var e in eventBox.values.toList()) {
                if (e.tags.contains(tag)) {
                  e.tags.remove(tag);
                  eventBox.put(e.id, e);
                }
              }
              Box tagBox = Hive.box<Tag>(tagBox);
              tagBox.deleteAt(allTags.indexWhere((t) => t.id == tag.id));
              allTags.removeWhere((t) => t.id == tag.id);
              update();
              Get.back();
            },
          ),
        ],
      ),
    );
  }

  @override
  String screenName() {
    return 'Tags';
  }
}
