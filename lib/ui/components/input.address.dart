import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/util/screen.dart';

class AddressInput extends StatelessWidget {
  final TextEditingController controller;
  final Function() onEditingComplete;
  final bool isLarge;
  final String hint;

  const AddressInput(
      {Key? key,
      required this.controller,
      required this.onEditingComplete,
      required this.hint,
      this.isLarge = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: isLarge ? 72 : 56,
      child: Card(
        elevation: isLarge ? 32 : 4,
        color: Colors.white,
        shadowColor: Colors.black26,
        child: Container(
          height: double.infinity,
          padding:
              EdgeInsets.symmetric(horizontal: 16, vertical: isLarge ? 0 : 0),
          alignment: Alignment.center,
          child: TextFormField(
            autofocus: true,
            controller: controller,
            cursorColor: const Color(0xFF6534FF),
            cursorRadius: const Radius.circular(8),
            cursorWidth: 2,
            style: GoogleFonts.courierPrime(
              color: Colors.black87,
              fontSize: isLarge ? 28 : 24,
            ),
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
            onEditingComplete: onEditingComplete,
          ),
        ),
      ),
    );
  }
}

class BottomInputBar extends StatelessWidget {
  final TextEditingController controller;
  final Function() onEditingComplete;
  final String hint;

  const BottomInputBar({
    Key? key,
    required this.controller,
    required this.onEditingComplete,
    required this.hint,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: PColor.background,
      elevation: 16,
      shadowColor: Colors.black45,
      child: Container(
        padding: EdgeInsets.only(
            bottom: MediaQuery.of(context).padding.bottom + 8, top: 8),
        margin: EdgeInsets.only(
          left: ScreenHelper.getHorizontalPadding(context),
          right: ScreenHelper.getHorizontalPadding(context),
        ),
        child: AddressInput(
          controller: controller,
          onEditingComplete: onEditingComplete,
          hint: hint,
        ),
      ),
    );
  }
}
