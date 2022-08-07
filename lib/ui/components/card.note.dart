import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class NoteCard extends StatelessWidget {
  final String content;
  final bool ok;
  final Function onOkTap;

  const NoteCard({
    Key? key,
    required this.content,
    this.ok = false,
    required this.onOkTap,
  }) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.yellow.shade100,
      elevation: 8,
      shadowColor: Colors.yellow.withAlpha(80),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            alignment: Alignment.centerLeft,
            padding: EdgeInsets.only(
                left: 16, right: 16, top: 16, bottom: ok ? 8 : 16),
            child: Text.rich(
              TextSpan(
                text: content,
                style: GoogleFonts.lato(
                  color: Colors.yellow.shade900,
                  fontSize: 16,
                  height: 1.5,
                ),
              ),
            ),
          ),
          !ok
              ? Container()
              : Row(
                  children: [
                    Expanded(child: Container()),
                    RawMaterialButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(8)),
                      child: Container(
                        padding: const EdgeInsets.all(8),
                        child: Text(
                          'Got it',
                          style: GoogleFonts.lato(
                            color: Colors.yellow.shade900,
                            fontSize: 16,
                            height: 1.5,
                          ),
                        ),
                      ),
                      onPressed: () {
                        onOkTap();
                      },
                    ),
                    const SizedBox(width: 8),
                  ],
                ),
        ],
      ),
    );
  }
}
