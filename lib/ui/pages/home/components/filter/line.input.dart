import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/pages/home/components/filter/title.dart';

class FilterInputLine extends StatelessWidget {
  final String title;
  final TextEditingController controller;
  final Function() onEditingComplete;
  final Function() onClearPressed;

  const FilterInputLine({
    Key? key,
    required this.title,
    required this.controller,
    required this.onEditingComplete,
    required this.onClearPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 48,
      child: Row(
        children: [
          FilterTitle(title: title),
          Expanded(
            child: Stack(
              children: [
                Container(
                  height: double.infinity,
                  padding: const EdgeInsets.only(
                    right: 16,
                  ),
                  alignment: Alignment.center,
                  child: TextFormField(
                    controller: controller,
                    cursorColor: const Color(0xFF6534FF),
                    cursorRadius: const Radius.circular(8),
                    cursorWidth: 2,
                    style: GoogleFonts.courierPrime(
                      color: Colors.orangeAccent.shade400,
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                    ),
                    decoration: InputDecoration(
                      border: null,
                      enabledBorder: InputBorder.none,
                      focusedBorder: InputBorder.none,
                      disabledBorder: InputBorder.none,
                      errorBorder: InputBorder.none,
                      focusedErrorBorder: InputBorder.none,
                      contentPadding: const EdgeInsets.symmetric(horizontal: 8),
                      hintText: title,
                      hintStyle: GoogleFonts.courierPrime(
                        color: Colors.black26,
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        // fontSize: 18,
                      ),
                    ),
                    onEditingComplete: onEditingComplete,
                  ),
                ),
                controller.text.isEmpty
                    ? Container()
                    : Positioned(
                        right: 0,
                        top: 0,
                        bottom: 0,
                        child: IconButton(
                          icon: Icon(Icons.cancel,
                              size: 16, color: Colors.blueGrey.shade100),
                          highlightColor: Colors.red.shade200.withOpacity(0.3),
                          splashColor:
                              Colors.redAccent.shade200.withOpacity(0.3),
                          onPressed: onClearPressed,
                        ),
                      ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
