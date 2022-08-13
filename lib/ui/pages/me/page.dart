import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:modal_bottom_sheet/modal_bottom_sheet.dart';
import 'package:poapin/controllers/controller.user.dart';
import 'package:poapin/res/colors.dart';
import 'package:poapin/ui/components/avatar.dart';
import 'package:poapin/ui/components/icons/forward.dart';
import 'package:poapin/ui/components/loading.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/auth/controller.dart';
import 'package:poapin/ui/pages/auth/page.dart';
import 'package:poapin/ui/pages/me/controller.dart';
import 'package:poapin/util/show_input.dart';

class MePage extends BasePage<MeController> {
  const MePage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  @override
  Widget getPage(BuildContext context) {
    return GetBuilder<MeController>(
      builder: (c) => Stack(
        children: [
          CustomScrollView(
            slivers: [
              SliverAppBar(
                pinned: false,
                elevation: 0,
                leading: null,
                centerTitle: true,
                backgroundColor: Colors.transparent,
                title: Text(
                  'POAP.in',
                  overflow: TextOverflow.fade,
                  style: GoogleFonts.carterOne(
                    color: const Color(0xFF6534FF),
                    shadows: [
                      Shadow(
                          color: Colors.white.withOpacity(0.8),
                          offset: const Offset(1, 1),
                          blurRadius: 2),
                    ],
                  ),
                ),
              ),
              SliverToBoxAdapter(
                child: ProfileCard(
                  horizontalPadding: getHorizontalPadding(context),
                ),
              ),
              SliverToBoxAdapter(
                child: ConnectWalletCard(
                  horizontalPadding: getHorizontalPadding(context),
                ),
              ),
              const SliverPadding(padding: EdgeInsets.symmetric(vertical: 16)),
              SliverToBoxAdapter(
                child: GetBuilder<UserController>(
                  builder: (c) => !c.isSignedIn
                      ? Container()
                      : Container(
                          margin: const EdgeInsets.only(top: 0),
                          alignment: Alignment.center,
                          padding: EdgeInsets.symmetric(
                              vertical: 16,
                              horizontal: getHorizontalPadding(context)),
                          child: Material(
                            shape: const RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.all(Radius.circular(16))),
                            clipBehavior: Clip.antiAlias,
                            child: MeItem(
                              title: 'Tags',
                              onTap: () {
                                Get.toNamed('/tags');
                              },
                              icon: Icon(
                                Icons.local_offer,
                                color: Colors.blueGrey.shade300,
                              ),
                              desc: 'Manage your tags.',
                            ),
                          ),
                        ),
                ),
              ),
              GetBuilder<UserController>(
                builder: (c) => SliverToBoxAdapter(
                  child: Container(
                    margin: const EdgeInsets.only(top: 16),
                    alignment: Alignment.center,
                    padding: EdgeInsets.symmetric(
                        horizontal: getHorizontalPadding(context)),
                    child: Material(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          MeItem(
                            title: 'Settings',
                            onTap: () {
                              Get.toNamed('/setting');
                            },
                            icon: Icon(
                              Icons.settings_suggest,
                              color: Colors.blueGrey.shade300,
                            ),
                            desc: 'Notifications, data, etc.',
                          ),
                          Container(height: 1, color: PColor.background),
                          kIsWeb
                              ? Container()
                              : !c.isSignedIn
                                  ? MeAuthItem(
                                      title: 'Sign in',
                                      isSignIn: true,
                                      onTap: () async {
                                        Get.lazyPut(() => AuthController());
                                        showMaterialModalBottomSheet(
                                          context: context,
                                          enableDrag: true,
                                          builder: (context) =>
                                              const AuthPage(),
                                        );
                                      },
                                    )
                                  : MeAuthItem(
                                      title: 'Log out',
                                      onTap: () async {
                                        await FirebaseAuth.instance.signOut();
                                        c.isGetingUserInfo = false;
                                        c.update();
                                      },
                                    ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ],
          ),
          Obx(() => controller.isLoading.value
              ? const Center(
                  child: LoadingAnimation(),
                )
              : const SizedBox()),
        ],
      ),
    );
  }
}

class ConnectWalletCard extends StatelessWidget {
  final double horizontalPadding;

  const ConnectWalletCard({Key? key, required this.horizontalPadding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetBuilder<UserController>(
      builder: (c) {
        if (c.isSignedIn && c.user.eth.isEmpty) {
          return Stack(
            children: [
              Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: const BorderRadius.vertical(),
                    border: Border.all(color: Colors.black12, width: 1)),
                margin:
                    EdgeInsets.symmetric(horizontal: horizontalPadding + 16),
                child: RawMaterialButton(
                  onPressed: () {
                    c.launchURL('https://poap.in/profile');
                  },
                  child: Container(
                      height: 40,
                      width: double.infinity,
                      margin: const EdgeInsets.only(top: 8, bottom: 8, left: 8),
                      child: Row(
                        children: [
                          const WalletTips(),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              'Sign in with browser & connect wallet.',
                              style: GoogleFonts.courierPrime(
                                color: Colors.blueGrey.shade300,
                                fontSize: 12,
                                fontWeight: FontWeight.normal,
                              ),
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          const ForwardIcon(),
                          const SizedBox(
                            width: 8,
                          ),
                        ],
                      )),
                ),
              ),
              Positioned(
                  child: Container(
                margin:
                    EdgeInsets.symmetric(horizontal: horizontalPadding + 17),
                height: 1,
                color: Colors.white,
              )),
            ],
          );
        }
        return Container();
      },
    );
  }
}

class ProfileCard extends StatelessWidget {
  final double horizontalPadding;

  const ProfileCard({Key? key, required this.horizontalPadding})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: horizontalPadding),
      child: Material(
        color: const Color(0xFFF3F3F3),
        shadowColor: Colors.black26,
        elevation: 12,
        shape: const ContinuousRectangleBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(24),
          ),
        ),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              const SizedBox(width: 8),
              Stack(
                children: [
                  const POAPinAvatar(),
                  GetBuilder<UserController>(builder: (c) {
                    return Positioned.fill(
                      child: VerifiedBadge(isVerified: c.user.eth.isNotEmpty),
                    );
                  }),
                ],
              ),
              const SizedBox(width: 8),
              GetBuilder<MeController>(builder: (c) {
                return Expanded(
                  child: RawMaterialButton(
                    onPressed: () {
                      // InputHelper.showBottomInput(context, 'ETH address or ENS',
                      //     c.addressController, c.onSubmit);
                      Get.toNamed('/profile');
                    },
                    fillColor: Colors.white,
                    elevation: 0,
                    focusElevation: 0,
                    hoverElevation: 0,
                    highlightElevation: 0,
                    shape: const ContinuousRectangleBorder(
                      borderRadius: BorderRadius.all(
                        Radius.circular(36),
                      ),
                    ),
                    child: GetBuilder<MeController>(
                      builder: (c) => Container(
                        height: 88,
                        alignment: Alignment.centerLeft,
                        padding: const EdgeInsets.symmetric(
                            vertical: 8, horizontal: 12),
                        child: GetBuilder<UserController>(
                          builder: (uc) => Row(
                            children: [
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceEvenly,
                                  children: [
                                    FittedBox(
                                      alignment: Alignment.centerLeft,
                                      fit: BoxFit.scaleDown,
                                      child: Text(
                                        c.ensAddress == ''
                                            ? 'Anonymous'
                                            : c.ensAddress,
                                        maxLines: 1,
                                        style: GoogleFonts.pressStart2p(
                                          color: (uc.isSignedIn &&
                                                  uc.user.eth.isNotEmpty)
                                              ? const Color(0x886534FF)
                                              : Colors.black54,
                                          fontSize: 18,
                                          fontWeight: FontWeight.bold,
                                          shadows: [
                                            Shadow(
                                                color: Colors.white
                                                    .withOpacity(0.9),
                                                offset: const Offset(2, 1),
                                                blurRadius: 0),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(height: 14),
                                    Text(
                                      c.ethAddress == ''
                                          ? 'Set ETH address'
                                          : c.getSimpleAddress(c.ethAddress),
                                      maxLines: 1,
                                      softWrap: false,
                                      overflow: TextOverflow.fade,
                                      style: GoogleFonts.pressStart2p(
                                        color: (uc.isSignedIn &&
                                                uc.user.eth.isNotEmpty)
                                            ? const Color(0x886534FF)
                                            : Colors.black54,
                                        fontSize: 10,
                                        fontWeight: FontWeight.normal,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              const ForwardIcon(),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                );
              }),
              const SizedBox(width: 8),
            ],
          ),
        ),
      ),
    );
  }
}

class VerifiedBadge extends StatelessWidget {
  final bool isVerified;

  const VerifiedBadge({Key? key, required this.isVerified}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        !isVerified
            ? Container()
            : Positioned(
                right: 5,
                bottom: 5,
                child: Container(
                  width: 26,
                  height: 26,
                  decoration: const BoxDecoration(
                    shape: BoxShape.circle,
                    color: Colors.blueAccent,
                  ),
                )),
        !isVerified
            ? Container()
            : Positioned(
                right: 0,
                bottom: 0,
                child: Icon(
                  Icons.verified,
                  color: Colors.yellow.shade800,
                  size: 36,
                ),
              ),
        !isVerified
            ? Container()
            : const Positioned(
                right: 4,
                bottom: 4,
                child: Icon(
                  Icons.verified,
                  color: Colors.yellow,
                  size: 28,
                ),
              ),
      ],
    );
  }
}

class MeItem extends StatelessWidget {
  final String title;
  final String desc;
  final Widget icon;
  final Function() onTap;

  const MeItem(
      {Key? key,
      required this.title,
      required this.desc,
      required this.icon,
      required this.onTap})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.white,
      elevation: 0.6,
      onPressed: onTap,
      hoverElevation: 0,
      highlightElevation: 0,
      hoverColor: Theme.of(context).primaryColorLight.withOpacity(0.2),
      splashColor: Theme.of(context).primaryColorLight.withOpacity(0.5),
      highlightColor: Theme.of(context).primaryColorLight.withOpacity(0.3),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Text(
                    desc,
                    style: GoogleFonts.lato(
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.black45,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MeAuthItem extends StatelessWidget {
  final String title;
  final Function() onTap;
  final bool? isSignIn;

  const MeAuthItem(
      {Key? key,
      required this.title,
      required this.onTap,
      this.isSignIn = false})
      : super(key: key);
  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      fillColor: Colors.white,
      elevation: 0,
      onPressed: onTap,
      hoverElevation: 0,
      highlightElevation: 0,
      hoverColor: Theme.of(context).primaryColorLight.withOpacity(0.2),
      splashColor: Theme.of(context).primaryColorLight.withOpacity(0.5),
      highlightColor: Theme.of(context).primaryColorLight.withOpacity(0.3),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 8),
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(isSignIn! ? Icons.login : Icons.logout,
                color: Colors.blueGrey.shade300),
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    maxLines: 1,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class WalletTips extends StatelessWidget {
  const WalletTips({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return RawMaterialButton(
      onPressed: () {
        Get.defaultDialog(
          radius: 24,
          titlePadding: const EdgeInsets.all(16),
          contentPadding: const EdgeInsets.all(16),
          title: 'Connect Wallet',
          titleStyle: GoogleFonts.carterOne(
            fontSize: 24,
            fontWeight: FontWeight.w500,
            color: Colors.black54,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(
                'Sign in on the web with Google or Apple to the same account as the one you are currently signed in to in the app.\n\nThen bind your primary wallet address. Binding of multiple wallet addresses will be available soon.',
                style: GoogleFonts.roboto(
                  fontSize: 14,
                  color: Colors.black54,
                  height: 1.5,
                ),
              ),
            ],
          ),
        );
      },
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      constraints: const BoxConstraints(minWidth: 8),
      child: Container(
        height: 48,
        padding: const EdgeInsets.symmetric(horizontal: 8),
        child: Icon(
          Icons.account_balance_wallet_outlined,
          color: Colors.blueGrey.shade300,
        ),
      ),
    );
  }
}
