import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/pages/home/components/wrapper.bottomsheet.dart';
import 'package:poapin/ui/pages/home/controller.dart';

class TagsView extends StatelessWidget {
  const TagsView({Key? key}) : super(key: key);

  List<Widget> _buildCountries(BuildContext context, Map tags) {
    HomeController controller = Get.find<HomeController>();
    List<Widget> _tags = [];
    tags.forEach(
      (tag, value) {
        _tags.add(
          RawMaterialButton(
            onPressed: () {
              controller.setFilterByTag(value.keys.first);
              Get.back();
            },
            child: Container(
                height: 56,
                margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 0),
                child: Row(
                  children: [
                    Container(
                      constraints: BoxConstraints(
                          maxWidth: MediaQuery.of(context).size.width * 0.8),
                      child: Text(
                        '${value.keys.first.name}',
                        maxLines: 1,
                        softWrap: false,
                        overflow: TextOverflow.ellipsis,
                        style: GoogleFonts.courierPrime(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).primaryColorDark,
                        ),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Text(
                      '',
                      style: GoogleFonts.epilogue(
                        fontSize: 18,
                        color: Theme.of(context).primaryColorLight,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                )),
          ),
        );
      },
    );
    return _tags;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(
      content: GetBuilder<HomeController>(
        builder: (c) =>
            ListView(padding: EdgeInsets.zero, shrinkWrap: true, children: [
          const SizedBox(height: 24),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'Tags',
              style: GoogleFonts.epilogue(fontSize: 16, color: Colors.black54),
            ),
          ),
          const SizedBox(height: 16),
          ..._buildCountries(context, c.tags),
          const SizedBox(height: 16),
        ]),
      ),
    );
  }
}
