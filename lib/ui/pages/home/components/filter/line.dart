import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/ui/pages/home/components/filter/title.dart';

class FilterLine extends StatelessWidget {
  final String title;
  final String content;
  final String hint;
  final Function() onPressed;
  final Function() onClearPressed;

  const FilterLine({
    Key? key,
    required this.title,
    required this.content,
    required this.hint,
    required this.onPressed,
    required this.onClearPressed,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 56,
      child: Row(
        children: [
          FilterTitle(title: title),
          Expanded(
            child: Stack(
              children: [
                RawMaterialButton(
                  onPressed: onPressed,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(8)),
                  child: Container(
                    alignment: Alignment.centerLeft,
                    padding: const EdgeInsets.symmetric(horizontal: 8),
                    child: content.isEmpty
                        ? Text(
                            hint,
                            style: GoogleFonts.courierPrime(
                              color: Colors.black26,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          )
                        : Text(
                            content,
                            style: GoogleFonts.courierPrime(
                              color: Colors.orangeAccent.shade400,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                  ),
                ),
                content.isEmpty
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
