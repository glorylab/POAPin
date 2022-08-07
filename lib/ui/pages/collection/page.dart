import 'package:flutter/material.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/collection/components/content.dart';
import 'package:poapin/ui/pages/collection/controller.dart';

class CollectionPage extends BasePage<CollectionController> {
  const CollectionPage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  @override
  Widget getPage(BuildContext context) {
    double width = MediaQuery.of(context).size.width;

    double getHorizontalPadding() {
      if (width > 768) {
        return (width - 768) / 2;
      } else {
        return 16;
      }
    }

    return Center(
        child: CollectionContent(horizontalPadding: getHorizontalPadding()),
    );
  }
}
