import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:rive/rive.dart' hide LinearGradient;

class JournalAppBar extends StatelessWidget {
  const JournalAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {

    return SliverAppBar(
      backgroundColor: Colors.white,
      automaticallyImplyLeading: false,
      flexibleSpace: SizedBox(
        width: double.infinity,
        height: double.infinity,
        child: Stack(
          children: [
            Positioned.fill(
              child: SizedBox(
                width: double.infinity,
                height: double.infinity,
                child: RiveAnimation.asset(
                  'assets/animation/dynamic_bg.riv',
                  fit: BoxFit.cover,
                  placeHolder: Container(
                    decoration: const BoxDecoration(
                        gradient: LinearGradient(
                      begin: Alignment.topRight,
                      end: Alignment.bottomLeft,
                      stops: [
                        0.3,
                        0.6,
                        0.8,
                      ],
                      colors: [
                        Color(0xFF965DE9),
                        Color(0xFF6358EE),
                        Colors.indigo,
                      ],
                    )),
                  ),
                ),
              ),
            ),
            SafeArea(
              child: Center(
                child: Text(
                  strJournal,
                  style: GoogleFonts.carterOne(
                    color: Colors.white70,
                    fontSize: 24,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
      floating: true,
      pinned: true,
      expandedHeight: 256,
    );
  }
}
