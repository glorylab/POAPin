import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/pages/home/components/filter/view.expaned_hint.dart';

class HintView extends StatelessWidget {
  const HintView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 56,
      color: Colors.white,
      child: Row(
        children: [
          Expanded(
            child: RawMaterialButton(
              onPressed: () {
                showMaterialModalBottomSheet(
                  expand: false,
                  context: context,
                  duration: const Duration(milliseconds: 100),
                  builder: (context) => const ExpandedHintView(),
                  backgroundColor: Colors.transparent,
                );
              },
              child: Container(
                  height: 56,
                  alignment: Alignment.centerLeft,
                  padding: const EdgeInsets.symmetric(
                    horizontal: 12,
                  ),
                  child: Row(
                    children: [
                      const Icon(
                        Icons.search,
                        color: Colors.black26,
                      ),
                      const SizedBox(
                        width: 8,
                      ),
                      Expanded(
                        child: Text(
                          strFilterHint,
                          maxLines: 1,
                          overflow: TextOverflow.fade,
                          softWrap: false,
                          style: GoogleFonts.epilogue(
                            color: Colors.black26,
                          ),
                        ),
                      ),
                    ],
                  )),
            ),
          ),
        ],
      ),
    );
  }
}
