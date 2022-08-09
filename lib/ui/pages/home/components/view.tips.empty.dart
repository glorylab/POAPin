import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:url_launcher/url_launcher.dart';

/// When an address's POAP is empty, this content is displayed.
class EmptyTips extends StatelessWidget {
  const EmptyTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.center,
      padding: const EdgeInsets.symmetric(
        vertical: 32,
      ),
      constraints: const BoxConstraints(
        maxWidth: 340,
      ),
      child: Column(
        children: [
          Container(
            margin: const EdgeInsets.symmetric(horizontal: 16),
            constraints: const BoxConstraints(
              maxWidth: 340,
            ),
            child: Text(
              'You don\'t appear to have any POAP right now. \nBut it\'s not too late! \n\nBegin learning about POAP right here!',
              style: GoogleFonts.roboto(
                fontSize: 16,
                color: Colors.grey.shade600,
              ),
            ),
          ),
          const SizedBox(height: 32),
          const TipItem(
            icon: 'poap',
            text: 'POAP.xyz',
            url: 'https://poap.xyz',
          ),
          const SizedBox(height: 12),
          const TipItem(
            icon: 'poap',
            text: 'POAP.directory',
            url: 'https://poap.directory',
          ),
          const SizedBox(height: 12),
          const TipItem(
            icon: 'gitpoap',
            text: 'GitPOAP',
            url: 'https://www.gitpoap.io/',
          ),
        ],
      ),
    );
  }
}

class TipItem extends StatelessWidget {
  const TipItem(
      {Key? key, required this.icon, required this.text, required this.url})
      : super(key: key);

  final String icon;
  final String text;
  final String url;

  void launchURL(String url) async {
    if (!await launch(url, forceSafariVC: false, forceWebView: false)) {
      throw 'Could not launch $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.white,
      elevation: 0,
      shape: const ContinuousRectangleBorder(
        borderRadius: BorderRadius.all(
          Radius.circular(
            24,
          ),
        ),
      ),
      onPressed: () {
        launchURL(url);
      },
      child: Container(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
          child: Row(
            children: [
              Image.asset(
                'icons/ic_$icon.png',
                package: 'web3_icons',
                width: 36.0,
                height: 36.0,
              ),
              const SizedBox(width: 8),
              Text(
                text,
                style: GoogleFonts.robotoMono(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                  color: Colors.grey.shade900,
                ),
              ),
            ],
          )),
    );
  }
}
