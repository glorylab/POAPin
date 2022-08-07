import 'package:flutter/material.dart';

class POAPinAvatar extends StatelessWidget {
  const POAPinAvatar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      width: 88,
      child: Center(
        child: Stack(
          children: [
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.only(
                bottom: 0,
              ),
              child: const Material(
                elevation: 1,
                shadowColor: Color(0xAA6534FF),
                shape: CircleBorder(),
                color: Colors.white,
                child: SizedBox(
                  height: 88,
                  width: 88,
                ),
              ),
            ),
            Container(
              alignment: Alignment.center,
              padding: const EdgeInsets.all(
                4,
              ),
              child: RawMaterialButton(
                onPressed: () {
                  return;
                },
                clipBehavior: Clip.antiAlias,
                shape: const CircleBorder(),
                elevation: 0,
                highlightElevation: 0,
                fillColor: Colors.white,
                child: Container(
                  height: 88,
                  width: 88,
                  decoration: BoxDecoration(
                      gradient: LinearGradient(
                    begin: Alignment.topRight,
                    end: Alignment.bottomLeft,
                    stops: const [
                      0.3,
                      0.6,
                      0.8,
                    ],
                    colors: [
                      const Color(0xAA965DE9),
                      const Color(0xAA6358EE),
                      Colors.indigo.withOpacity(0.6),
                    ],
                  )),
                  alignment: Alignment.center,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
