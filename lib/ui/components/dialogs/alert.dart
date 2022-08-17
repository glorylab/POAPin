import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AlertDialogContent extends StatelessWidget {
  const AlertDialogContent(
      {Key? key,
      required this.title,
      required this.content,
      required this.onPressed,
      required this.onCancled,
      required this.mainButtonText})
      : super(key: key);

  final String title;
  final String content;
  final String mainButtonText;
  final Function onPressed;
  final Function onCancled;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Stack(
        children: [
          Positioned(
            bottom: 0,
            left: 48,
            right: 48,
            child: SizedBox(
              height: 56,
              child: Row(
                children: [
                  RawMaterialButton(
                    fillColor: Colors.white,
                    shape: ContinuousRectangleBorder(
                      borderRadius: BorderRadius.circular(24),
                    ),
                    elevation: 16,
                    highlightElevation: 2,
                    constraints: const BoxConstraints(
                      minWidth: 48,
                      minHeight: 48,
                    ),
                    onPressed: () => onCancled(),
                    child: const SizedBox(
                      height: 56,
                      width: 56,
                      child: Icon(
                        Icons.close,
                        color: Colors.black54,
                      ),
                    ),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    child: Container(),
                  )
                ],
              ),
            ),
          ),
          Container(
            margin:
                const EdgeInsets.only(left: 32, right: 32, bottom: 44, top: 32),
            child: Material(
              color: Colors.white,
              shadowColor: Colors.black54,
              elevation: 8,
              shape: const ContinuousRectangleBorder(
                borderRadius: BorderRadius.all(Radius.circular(56)),
                side: BorderSide(color: Color(0xFFD2D2D2), width: 4),
              ),
              child: Container(
                padding:
                    const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
                constraints: const BoxConstraints(
                    maxWidth: 600,
                    minWidth: 320,
                    minHeight: 128,
                    maxHeight: 512),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      title,
                      style: GoogleFonts.robotoSlab(
                        fontSize: 24,
                        fontWeight: FontWeight.bold,
                        color: Colors.red[300],
                      ),
                    ),
                    const SizedBox(height: 16),
                    Text(
                      content,
                      style: GoogleFonts.robotoMono(
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.red[300],
                      ),
                    ),
                    const SizedBox(height: 56),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            bottom: 0,
            left: 48,
            right: 48,
            child: SizedBox(
              height: 56,
              child: Row(
                children: [
                  Expanded(
                    flex: 4,
                    child: Container(),
                  ),
                  const SizedBox(width: 16),
                  Expanded(
                    flex: 5,
                    child: RawMaterialButton(
                      fillColor: Colors.red.shade500,
                      shape: ContinuousRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                        side: BorderSide(color: Colors.red.shade600, width: 2),
                      ),
                      elevation: 16,
                      highlightElevation: 32,
                      onPressed: () {
                        onPressed();
                      },
                      child: Container(
                        height: 56,
                        alignment: Alignment.center,
                        child: Text(
                          mainButtonText,
                          style: GoogleFonts.robotoMono(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
