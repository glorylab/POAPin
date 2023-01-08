import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:poapin/res/colors.dart';

class DynamicIslandView extends StatelessWidget {
  const DynamicIslandView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32,
      color: Colors.white,
      clipBehavior: Clip.antiAlias,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(66)),
      ),
      child: Container(
        height: 56,
        margin: const EdgeInsets.only(top: 2, left: 3, right: 3),
        child: Row(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
          Expanded(
            child: Hero(
              tag: 'island',
              child: RawMaterialButton(
                onPressed: () {
                  Get.to(
                    () => const IslandView(),
                    opaque: true,
                    transition: Transition.downToUp,
                  );
                },
                fillColor: const Color(0xFFF6F6F6),
                shape: const ContinuousRectangleBorder(
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(64),
                    topRight: Radius.circular(16),
                  ),
                ),
                child: Row(children: [
                  const SizedBox(width: 8),
                  Image.asset(
                    'icons/ic_poap.png',
                    package: 'web3_icons',
                    color: PColor.primary.withOpacity(0.4),
                    width: 24,
                    height: 24,
                  ),
                  const SizedBox(width: 8),
                  const Text(
                    'poap.eth',
                    style: TextStyle(color: Color(0xFFA0A0A0), fontSize: 16),
                  ),
                ]),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.keyboard_double_arrow_up_rounded),
            onPressed: () {},
          ),
        ]),
      ),
    );
  }
}

class IslandView extends StatelessWidget {
  const IslandView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: 'island',
      child: Container(
        color: Colors.white,
        child: SafeArea(
          child: Container(
              margin: const EdgeInsets.all(32),
              child: const Material(
                child: Center(
                  child: Text(
                    'Island',
                    style: TextStyle(
                      color: Colors.green,
                      fontSize: 32,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              )),
        ),
      ),
    );
  }
}
