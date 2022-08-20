import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/locale_string.dart';

class LanguagesDialog extends StatelessWidget {
  const LanguagesDialog({
    Key? key,
  }) : super(key: key);

  _buildLanguageList() {
    var languages = LocaleString().getAllLanguage();
    return ListView.builder(
      itemCount: languages.length + 1,
      itemBuilder: (context, index) {
        if (index == 0) {
          return const SizedBox(
            height: 64,
          );
        }
        return ListTile(
          title: Text(languages[index - 1]['name']),
          minVerticalPadding: 8,
          shape: ContinuousRectangleBorder(
            borderRadius: BorderRadius.circular(24),
          ),
          onTap: () {
            print(languages[index - 1]['locale']);
          },
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.center,
      child: Container(
        margin: const EdgeInsets.only(left: 32, right: 32, bottom: 44, top: 32),
        child: Material(
          color: Colors.white,
          shadowColor: Colors.black54,
          elevation: 8,
          shape: const ContinuousRectangleBorder(
            borderRadius: BorderRadius.all(Radius.circular(56)),
            side: BorderSide(color: Color(0xFFD2D2D2), width: 4),
          ),
          child: Container(
            padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
            constraints: const BoxConstraints(
                maxWidth: 600, minWidth: 320, minHeight: 128, maxHeight: 512),
            child: Stack(
              children: [
                _buildLanguageList(),
                SizedBox(
                  height: 56,
                  child: Material(
                    elevation: 20,
                    shadowColor: Colors.black26,
                    shape: const ContinuousRectangleBorder(
                      borderRadius:
                          BorderRadius.vertical(bottom: Radius.circular(56)),
                    ),
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 16, vertical: 12),
                      width: double.infinity,
                      child: Text(
                        'Language',
                        textAlign: TextAlign.center,
                        style: GoogleFonts.robotoSlab(
                          fontSize: 24,
                          fontWeight: FontWeight.bold,
                          color: Colors.indigo[300],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
