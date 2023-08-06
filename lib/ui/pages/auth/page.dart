import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/auth/controller.dart';

class AuthPage extends BasePage<AuthController> {
  const AuthPage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  @override
  Widget getPage(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.amber.shade50,
      body: CustomScrollView(slivers: [
        SliverPadding(
          padding: EdgeInsets.only(
              top: MediaQuery.of(context).viewPadding.top,
              left: getHorizontalPadding(context),
              right: getHorizontalPadding(context)),
          sliver: SliverToBoxAdapter(
            child: Container(
              height: (MediaQuery.of(context).size.width -
                      getHorizontalPadding(context) * 2) /
                  1.6,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(46),
                color: Colors.white,
              ),
              margin: const EdgeInsets.all(
                16,
              ),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(46),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(
                  'assets/common/poapin_s.png',
                  fit: BoxFit.fitWidth,
                ),
              ),
            ),
          ),
        ),
        GetBuilder<AuthController>(
          builder: (c) => SliverPadding(
            padding: const EdgeInsets.only(top: 32),
            sliver: SliverToBoxAdapter(
              child: Container(
                margin: const EdgeInsets.all(
                  16,
                ),
                child: Column(children: [
                  GetPlatform.isIOS
                      ? AuthButton(
                          text: strSigninApple,
                          backgroundColor: Colors.grey.shade900,
                          onPressed: () {
                            controller.signInWithApple().then((value) {
                              if (value != null) {
                                Get.back();
                              }
                            });
                          },
                          isLoading: c.isAuthing,
                          isAuthing: c.isAppleAuthing,
                          logoAsset: 'apple',
                        )
                      : Container(),
                  const SizedBox(height: 16),
                  AuthButton(
                    text: strSigninGoogle,
                    backgroundColor: Colors.blue,
                    onPressed: () {
                      controller.signInWithGoogle().then((value) {
                        if (value != null) {
                          Get.back();
                        }
                      });
                    },
                    isLoading: c.isAuthing,
                    isAuthing: c.isGoogleAuthing,
                    logoAsset: 'google',
                  ),
                ]),
              ),
            ),
          ),
        ),
        SliverToBoxAdapter(
          child: Container(
            alignment: Alignment.center,
            margin: const EdgeInsets.all(
              16,
            ),
            child: RawMaterialButton(
              onPressed: () {
                controller.launchURL('api.poap.in', 'privacy');
              },
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                child: Text(
                  strTos,
                  style: GoogleFonts.roboto(
                    fontSize: 12,
                    fontWeight: FontWeight.w500,
                    color: Colors.grey.shade500,
                  ),
                ),
              ),
            ),
          ),
        ),
      ]),
    );
  }
}

class AuthButton extends StatelessWidget {
  final String text;
  final Function() onPressed;
  final Color backgroundColor;
  final bool isAuthing;
  final bool isLoading;
  final String logoAsset;

  const AuthButton({
    Key? key,
    required this.text,
    required this.onPressed,
    required this.backgroundColor,
    required this.isAuthing,
    required this.isLoading,
    this.logoAsset = '',
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: isAuthing
          ? backgroundColor
          : isLoading
              ? backgroundColor.withOpacity(0.6)
              : backgroundColor,
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(40),
        side: BorderSide(
          color: Colors.amber.shade100,
          width: 4,
        ),
      ),
      onPressed: isAuthing ? null : onPressed,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 28, vertical: 24),
        child: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            Image.asset(
              'assets/common/ic_$logoAsset.png',
              width: 18,
              height: 18,
              color: Colors.white,
            ),
            const SizedBox(width: 16),
            Text(
              isAuthing ? '...' : text,
              style: GoogleFonts.firaMono(
                fontSize: 18,
                fontWeight: FontWeight.w600,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
