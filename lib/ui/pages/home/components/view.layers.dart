import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/pages/home/components/wrapper.bottomsheet.dart';

import 'package:poapin/ui/pages/home/controller.dart';

class LayersView extends StatelessWidget {
  const LayersView({Key? key}) : super(key: key);

  List<Widget> _buildLayers(BuildContext context) {
    HomeController controller = Get.find<HomeController>();
    List<Widget> _layers = [];
    controller.chains.forEach(
      (layer, value) {
        _layers.add(
          RawMaterialButton(
            onPressed: () {
              controller.setFilterByChain(layer);
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
                        '$layer',
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
                      '$value',
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
    return _layers;
  }

  @override
  Widget build(BuildContext context) {
    return BottomSheetWrapper(
      content: GetBuilder<HomeController>(
        builder: (c) => ListView(
          shrinkWrap: true,
          padding: EdgeInsets.zero,
          children: [
            const SizedBox(height: 24),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Text(
                'Chains',
                style:
                    GoogleFonts.epilogue(fontSize: 16, color: Colors.black54),
              ),
            ),
            const SizedBox(height: 16),
            ..._buildLayers(context),
            const SizedBox(height: 16),
          ],
        ),
      ),
    );
  }
}
