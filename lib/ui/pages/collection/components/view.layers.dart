import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/pages/collection/controller.dart';

class LayersView extends StatelessWidget {
  const LayersView({Key? key}) : super(key: key);

  List<Widget> _buildLayers(BuildContext context) {
    CollectionController controller = Get.find<CollectionController>();
    List<Widget> _layers = [];
    controller.layers.value.forEach(
      (layer, value) {
        _layers.add(
          RawMaterialButton(
            onPressed: () {
              controller.setFilterByLayer(layer);
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
    return Center(
      child: Container(
        constraints: BoxConstraints(
            maxWidth: 512,
            maxHeight: 7 * MediaQuery.of(context).size.height / 11),
        margin: const EdgeInsets.symmetric(horizontal: 0),
        child: Material(
          color: Colors.white,
          shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(16), topRight: Radius.circular(16)),
          ),
          clipBehavior: Clip.antiAlias,
          elevation: 16,
          child: SafeArea(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 24),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: Text(
                    'Layers',
                    style: GoogleFonts.epilogue(
                        fontSize: 16, color: Colors.black54),
                  ),
                ),
                const SizedBox(height: 16),
                Expanded(
                  child: ListView(
                    children: [
                      _buildLayers(context),
                    ].expand((x) => x).toList(),
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
