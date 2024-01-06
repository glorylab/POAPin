import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/pages/journal/controllers/island.dart';
import 'package:poapin/util/screen.dart';

class ContentInput extends StatelessWidget {
  final bool isLarge;
  final String hint;

  const ContentInput({Key? key, required this.hint, this.isLarge = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 72,
      child: Stack(
        children: [
          Positioned(
            left: 0,
            top: 0,
            bottom: 0,
            right: 0,
            child: Card(
              elevation: isLarge ? 32 : 4,
              color: Colors.white,
              shadowColor: Colors.black26,
              shape: ContinuousRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              child: Container(
                height: double.infinity,
                width: double.infinity,
                padding: EdgeInsets.symmetric(
                    horizontal: 16, vertical: isLarge ? 0 : 0),
                alignment: Alignment.center,
                child: GetBuilder<JournalIslandController>(
                  builder: (c) => TextFormField(
                    autofocus: true,
                    controller: c.textEditController,
                    onFieldSubmitted: (value) {
                      c.onSubmit();
                    },
                    cursorColor: const Color(0xFF6534FF),
                    cursorRadius: const Radius.circular(8),
                    cursorWidth: 2,
                    style: GoogleFonts.courierPrime(
                      color: Colors.black87,
                      fontSize: isLarge ? 28 : 24,
                    ),
                    autocorrect: false,
                    enableSuggestions: false,
                    decoration: InputDecoration(
                      border: null,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      hintText: hint,
                      hintStyle: GoogleFonts.courierPrime(
                        color: Colors.black26,
                        fontSize: isLarge ? 24 : 18,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          ),
          // const Positioned(
          //   right: 0,
          //   top: 0,
          //   bottom: 0,
          //   child: PasteButton(),
          // ),
        ],
      ),
    );
  }
}

class InputDescription extends StatelessWidget {
  const InputDescription({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomCenter,
      padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 12),
      margin: EdgeInsets.only(
        left: ScreenHelper.getHorizontalPadding(context),
        right: ScreenHelper.getHorizontalPadding(context),
      ),
      child: Material(
        type: MaterialType.transparency,
        shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(56))),
        clipBehavior: Clip.antiAlias,
        child: Container(
          alignment: Alignment.bottomCenter,
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [Color(0x00FFFFFF), Color(0xFFFFFFFF)],
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
            ),
            borderRadius: BorderRadius.circular(16),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Text(
            'To explore POAP collections, enter an Ethereum address, ENS or email.',
            style: GoogleFonts.robotoMono(
              color: Colors.black38,
              fontSize: 14,
            ),
          ),
        ),
      ),
    );
  }
}

class InputShortcuts extends StatelessWidget {
  const InputShortcuts({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 88,
      alignment: Alignment.topCenter,
      margin: const EdgeInsets.only(bottom: 4),
      child: ListView.builder(
          scrollDirection: Axis.horizontal,
          reverse: true,
          itemCount: 3,
          itemBuilder: (context, index) {
            if (index == 0) {
              return const SizedBox(width: 16);
            }
            return Container(
              alignment: Alignment.center,
              margin: const EdgeInsets.only(right: 8),
              child: RawMaterialButton(
                constraints: const BoxConstraints(minWidth: 56),
                onPressed: (() {}),
                elevation: 0,
                shape: ContinuousRectangleBorder(
                    borderRadius: BorderRadius.circular(24)),
                fillColor: Colors.yellow[50],
                child: Container(
                  height: 56,
                  alignment: Alignment.center,
                  padding: const EdgeInsets.symmetric(horizontal: 16),
                  child: const Text('...'),
                ),
              ),
            );
          }),
    );
  }
}

class ContentInputPage extends StatelessWidget {
  final TextEditingController controller;
  final Function() onEditingComplete;
  final String hint;

  const ContentInputPage({
    Key? key,
    required this.controller,
    required this.onEditingComplete,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      type: MaterialType.transparency,
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 8, top: 8),
        child: Stack(
          children: [
            Positioned.fill(
              child: Image.asset(
                'assets/common/poap_universe.png',
                width: double.infinity,
                height: double.infinity,
                repeat: ImageRepeat.repeat,
                color: PColor.primary.withOpacity(0.3),
              ),
            ),
            Positioned.fill(
              child: SafeArea(
                child: Column(
                  children: [
                    const Expanded(
                      child: InputDescription(),
                    ),
                    // const InputShortcuts(),
                    Container(
                      // width: 190,
                      width: double.infinity,
                      alignment: Alignment.bottomCenter,
                      margin: EdgeInsets.only(
                        left: ScreenHelper.getHorizontalPadding(context),
                        right: ScreenHelper.getHorizontalPadding(context),
                      ),
                      height: 72,
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          Expanded(
                            child: ContentInput(
                              hint: hint,
                            ),
                          ),
                          const ConfirmButton(),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

// class PasteButton extends StatelessWidget {
//   const PasteButton({Key? key}) : super(key: key);
//
//   @override
//   Widget build(BuildContext context) {
//     return GetBuilder<IslandController>(builder: (c) {
//       if (c.canPaste) {
//         return Container(
//           margin: const EdgeInsets.only(
//             top: 4,
//             bottom: 4,
//             right: 8,
//           ),
//           padding: const EdgeInsets.only(left: 4, top: 4, bottom: 4),
//           child: RawMaterialButton(
//             onPressed: c.paste,
//             fillColor: PColor.primary,
//             constraints: const BoxConstraints(minWidth: 16),
//             elevation: 2,
//             highlightElevation: 8,
//             shape: ContinuousRectangleBorder(
//               borderRadius: BorderRadius.circular(28),
//             ),
//             child: Container(
//                 padding: const EdgeInsets.symmetric(horizontal: 16),
//                 child: const Icon(
//                   Icons.paste,
//                   color: Colors.white,
//                 )),
//           ),
//         );
//       }
//       return Container();
//     });
//   }
// }

class ConfirmButton extends StatelessWidget {
  const ConfirmButton({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetBuilder<JournalIslandController>(builder: (c) {
      if (c.canPaste) {
        return const SizedBox(
          width: 2,
          height: 1,
        );
      }
      return Container(
        width: 56,
        padding: const EdgeInsets.only(left: 4, top: 4, bottom: 4),
        child: c.addressType == AddressType.invalid
            ? Container(
            alignment: Alignment.center,
            child: const Text(
              '👀',
              style: TextStyle(
                fontSize: 24,
              ),
            ))
            : RawMaterialButton(
          onPressed: c.isVerifying ? null : c.onSubmit,
          fillColor: c.isVerifying ? Colors.white : Colors.green,
          constraints: const BoxConstraints(minWidth: 16),
          elevation: c.isVerifying ? 0 : 8,
          highlightElevation: 0,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(48),
          ),
          child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: c.isVerifying
                  ? const SizedBox(
                width: 16,
                height: 16,
                child: CircularProgressIndicator(
                  strokeWidth: 2,
                  valueColor:
                  AlwaysStoppedAnimation<Color>(Colors.yellow),
                ),
              )
                  : const Icon(
                Icons.check,
                color: Colors.white,
              )),
        ),
      );
    });
  }
}
