import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/components/buttons/back.dart';
import 'package:poapin/ui/components/buttons/go_home.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/tags/controller.dart';

class TagsPage extends BasePage<TagsController> {
  const TagsPage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  List _buildTags(
    TagsController c,
  ) {
    return c.allTags.isEmpty
        ? []
        : c.allTags
            .map(
              (tag) => Slidable(
                key: const ValueKey(0),
                endActionPane: ActionPane(
                  motion: const StretchMotion(),
                  children: [
                    SlidableAction(
                      spacing: 1,
                      onPressed: (context) {
                        c.deleteTag(tag);
                      },
                      backgroundColor: Colors.red.shade300,
                      foregroundColor: Colors.white,
                      icon: Icons.delete,
                      label: 'Delete',
                    ),
                  ],
                ),
                child: RawMaterialButton(
                  fillColor: Colors.white,
                  elevation: 0,
                  onPressed: () async {
                    Get.toNamed(
                      '/tag/${tag.id}',
                      arguments: tag,
                    );
                  },
                  child: SizedBox(
                    height: 56,
                    child: Row(
                      children: [
                        const SizedBox(width: 16),
                        const Icon(
                          Icons.local_offer,
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
              ),
            )
            .toList();
  }

  @override
  Widget getPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Get.previousRoute == ''
            ? const GoHomeButton()
            : const GoBackButton(),
        elevation: 2,
        title: Text(
          'Tags',
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
      body: Container(
        alignment: Alignment.center,
        padding:
            EdgeInsets.symmetric(horizontal: getHorizontalPadding(context)),
        child: controller.allTags.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 56,
                    ),
                    Text(
                      'No tags yet',
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
                      'Add some while viewing your own POAP, very easy!',
                      style: GoogleFonts.lato(
                        fontSize: 20,
                        color: Colors.black54,
                      ),
                    ),
                  ],
                ),
              )
            : GetBuilder<TagsController>(
                builder: (c) => ListView(
                  children: [
                    const SizedBox(height: 16),
                    ..._buildTags(c),
                  ],
                ),
              ),
      ),
    );
  }
}
