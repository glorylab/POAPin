import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/data/models/holder.dart';
import 'package:poapin/ui/components/icons/forward.dart';
import 'package:poapin/ui/pages/detail/controller.dart';

class HoldersPreviewCard extends StatelessWidget {
  const HoldersPreviewCard({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      builder: (c) {
        return Container(
          height: 56,
          alignment: Alignment.topCenter,
          margin: const EdgeInsets.only(left: 8, right: 8, bottom: 16),
          child: const Stack(
            children: [
              HoldersContent(),
              HoldersHeader(),
              Positioned(
                right: 0,
                top: 0,
                bottom: 0,
                child: More(),
              )
            ],
          ),
        );
      },
    );
  }
}

class HoldersContent extends StatelessWidget {
  const HoldersContent({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      builder: (c) {
        return SizedBox(
          height: 56,
          child: Material(
            elevation: 8,
            clipBehavior: Clip.antiAlias,
            shadowColor: Colors.black12,
            color: Colors.white,
            shape: const ContinuousRectangleBorder(
              borderRadius: BorderRadius.all(
                Radius.circular(16),
              ),
            ),
            child: RawMaterialButton(
              onPressed: () {
                Get.toNamed(
                  '/event/${c.token.value.event.id}',
                  arguments: {
                    'event': c.token.value.event,
                    'page': 'holders',
                  },
                );
              },
              fillColor: Colors.white,
              splashColor: const Color(0x20489FEC),
              highlightColor: const Color(0x0BEC4899),
              elevation: 0,
              child: Row(
                children: [
                  const HoldersHeaderPlaceholder(),
                  Expanded(
                    child: SizedBox(
                      height: 56,
                      child: ListView(
                        scrollDirection: Axis.horizontal,
                        physics: const ClampingScrollPhysics(),
                        children: [
                          const SizedBox(width: 8),
                          ...c.holders
                              .map(
                                (h) => HolderItem(
                                  holder: h,
                                ),
                              ),
                        ],
                      ),
                    ),
                  ),
                  const SizedBox(width: 32),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HolderItem extends StatelessWidget {
  final Holder holder;

  const HolderItem({Key? key, required this.holder}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<DetailController>(
      builder: (c) {
        return Container(
          margin: const EdgeInsets.symmetric(
            horizontal: 4,
            vertical: 8,
          ),
          child: Material(
            color: Colors.yellow.shade50,
            elevation: 2,
            shadowColor: Colors.black26,
            shape: ContinuousRectangleBorder(
              borderRadius: BorderRadius.circular(16),
            ),
            child: Container(
              padding: const EdgeInsets.symmetric(
                horizontal: 4,
                vertical: 2,
              ),
              child: Column(
                children: [
                  Expanded(
                    child: Row(
                      children: [
                        Icon(
                          Icons.flash_on,
                          color: Colors.orangeAccent.shade700,
                          size: 12,
                        ),
                        Text(
                          holder.owner.tokensOwned.toString(),
                          style: GoogleFonts.robotoMono(
                            color: Colors.orangeAccent.shade700,
                            fontSize: 10,
                            fontWeight: FontWeight.w600,
                          ),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Text(
                      c.getHolderName(holder),
                      style: GoogleFonts.vt323(
                        color: Colors.indigo.shade500,
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

class HoldersHeader extends StatelessWidget {
  const HoldersHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: GetBuilder<DetailController>(
        builder: (c) {
          return SizedBox(
            height: 56,
            child: Material(
              color: Colors.white,
              elevation: 8,
              shadowColor: Colors.black38,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.only(
                  bottomRight: Radius.elliptical(88, 288),
                  topLeft: Radius.circular(16),
                  bottomLeft: Radius.circular(16),
                ),
              ),
              child: SizedBox(
                height: 48,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 12),
                    Icon(
                      Icons.people_rounded,
                      size: 16,
                      color: Colors.indigo.shade300,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Holders',
                      style: GoogleFonts.robotoMono(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.indigo.shade300,
                      ),
                    ),
                    const SizedBox(width: 4),
                    c.holdersCount > 0
                        ? Container(
                            height: 30,
                            constraints: const BoxConstraints(minWidth: 16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(30, 121, 134, 203),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                color: const Color.fromARGB(255, 173, 179, 212),
                                width: 1.6,
                              ),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            child: Text(
                              '${c.holdersCount}',
                              style: GoogleFonts.robotoMono(
                                fontSize: 14,
                                color: Colors.indigo.shade300,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(
                            height: 30,
                            width: 30,
                            alignment: Alignment.center,
                            child: const SizedBox(
                              width: 12,
                              height: 12,
                              child: CircularProgressIndicator(
                                strokeWidth: 0.4,
                              ),
                            ),
                          ),
                    const SizedBox(width: 8),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class HoldersHeaderPlaceholder extends StatelessWidget {
  const HoldersHeaderPlaceholder({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: GetBuilder<DetailController>(
        builder: (c) {
          return SizedBox(
            height: 56,
            child: Material(
              color: Colors.transparent,
              child: SizedBox(
                height: 48,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(width: 12),
                    Icon(
                      Icons.people_rounded,
                      size: 16,
                      color: Colors.indigo.shade300,
                    ),
                    const SizedBox(width: 4),
                    Text(
                      'Holders',
                      style: GoogleFonts.robotoMono(
                        fontSize: 15,
                        fontWeight: FontWeight.w500,
                        color: Colors.indigo.shade300,
                      ),
                    ),
                    const SizedBox(width: 4),
                    c.holdersCount > 0
                        ? Container(
                            height: 30,
                            constraints: const BoxConstraints(minWidth: 16),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(30, 121, 134, 203),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                color: const Color.fromARGB(255, 173, 179, 212),
                                width: 1.6,
                              ),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            child: Text(
                              '${c.holdersCount}',
                              style: GoogleFonts.robotoMono(
                                fontSize: 14,
                                color: Colors.indigo.shade300,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          )
                        : Container(
                            height: 30,
                            constraints: const BoxConstraints(minWidth: 32),
                            decoration: BoxDecoration(
                              color: const Color.fromARGB(30, 236, 72, 154),
                              borderRadius: const BorderRadius.all(
                                Radius.circular(10),
                              ),
                              border: Border.all(
                                color: const Color(0x55EC4899),
                                width: 3,
                              ),
                            ),
                            alignment: Alignment.center,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 4, vertical: 2),
                            child: Text(
                              '+',
                              style: GoogleFonts.robotoMono(
                                fontSize: 16,
                                color: const Color.fromARGB(255, 236, 72, 154),
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }
}

class More extends StatelessWidget {
  const More({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Material(
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.only(
            topRight: Radius.circular(16),
            bottomRight: Radius.circular(16),
          ),
        ),
        color: Colors.transparent,
        clipBehavior: Clip.antiAlias,
        child: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Color(0x00FFFFFF),
                Colors.white,
              ],
              stops: [0.0, 0.4],
            ),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              SizedBox(width: 32),
              ForwardIcon(),
              SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}
