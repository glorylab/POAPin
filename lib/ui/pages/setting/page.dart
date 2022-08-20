import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/components/buttons/back.dart';
import 'package:poapin/ui/components/buttons/go_home.dart';
import 'package:poapin/ui/page.base.dart';
import 'package:poapin/ui/pages/setting/controller.dart';

class SettingPage extends BasePage<SettingController> {
  const SettingPage({Key? key}) : super(key: key);

  @override
  Widget getLead() {
    return Container();
  }

  @override
  Widget getPage(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: Get.previousRoute == ''
            ? const GoHomeButton()
            : const GoBackButton(),
        elevation: 2,
        title: Text(
          strSettings,
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
      body: Hero(
        tag: 'setting',
        child: Container(
          alignment: Alignment.center,
          padding:
              EdgeInsets.symmetric(horizontal: getHorizontalPadding(context)),
          child: ListView(
            children: [
              _GroupTitle(title: strGeneral),
              GetBuilder<SettingController>(
                builder: (c) => SettingItem(
                    title: strLanguage,
                    desc: c.languageName,
                    icon: Icon(
                      Icons.public_rounded,
                      size: 24,
                      color: Colors.blueGrey.withOpacity(0.5),
                    ),
                    onTap: controller.showLanguageDialog),
              ),
              _GroupTitle(title: strData),
              SettingItem(
                  title: strCache,
                  desc: strCacheDesc,
                  icon: Icon(
                    Icons.data_usage,
                    size: 24,
                    color: Colors.blueGrey.withOpacity(0.5),
                  ),
                  onTap: controller.clearAllCache),
              _GroupTitle(title: strAbout),
              Material(
                shape: const RoundedRectangleBorder(
                    borderRadius: BorderRadius.all(Radius.circular(16))),
                clipBehavior: Clip.antiAlias,
                child: Column(
                  children: [
                    SettingItem(
                      title: strTwitter,
                      desc: strTwitterHandle,
                      icon: Image.asset(
                        'icons/ic_twitter.png',
                        package: 'web3_icons',
                        width: 24.0,
                        height: 24.0,
                      ),
                      onTap: () async {
                        controller.launchTwitter();
                      },
                      isRoundCorner: false,
                    ),
                    SettingItem(
                      title: strMirror,
                      desc: strMirrorAddress,
                      icon: Image.asset(
                        'icons/ic_mirror.png',
                        package: 'web3_icons',
                        width: 24.0,
                        height: 24.0,
                      ),
                      onTap: () async {
                        controller.launchMirror();
                      },
                      isRoundCorner: false,
                    ),
                    SettingItem(
                      title: strGitHub,
                      desc: strGitHubRepo,
                      icon: Image.asset(
                        'icons/ic_github.png',
                        package: 'web3_icons',
                        width: 24.0,
                        height: 24.0,
                      ),
                      onTap: () async {
                        controller.launchGitHub();
                      },
                      isRoundCorner: false,
                    ),
                    SettingItem(
                      title: strPOAPDotIn,
                      desc: strPOAPDotInURL,
                      icon: Image.asset(
                        'icons/ic_poapin.png',
                        package: 'web3_icons',
                        width: 24.0,
                        height: 24.0,
                      ),
                      onTap: () async {
                        controller.launchPOAPin();
                      },
                      isRoundCorner: false,
                    ),
                  ],
                ),
              ),
              GetBuilder<SettingController>(
                builder: (c) => _GroupTitle(title: c.getVersionString()),
              ),
              !kIsWeb
                  ? Container()
                  : Material(
                      shape: const RoundedRectangleBorder(
                          borderRadius: BorderRadius.all(Radius.circular(16))),
                      clipBehavior: Clip.antiAlias,
                      child: Column(
                        children: [
                          SettingItem(
                            title: 'APP download',
                            desc: 'iOS & Android',
                            icon: Icon(Icons.app_shortcut,
                                size: 24,
                                color: Colors.blueGrey.withOpacity(0.5)),
                            onTap: () async {
                              Get.toNamed('/app');
                            },
                            isRoundCorner: false,
                          ),
                        ],
                      ),
                    ),
            ],
          ),
        ),
      ),
    );
  }
}

class _GroupTitle extends StatelessWidget {
  final String title;

  const _GroupTitle({Key? key, required this.title}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: Container(
        height: 48,
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.only(left: 8),
        child: Text(
          title,
          style: GoogleFonts.lato(
            fontSize: 14,
            fontWeight: FontWeight.w500,
            color: Colors.black45,
          ),
        ),
      ),
    );
  }
}

class SettingItem extends StatelessWidget {
  final String title;
  final String desc;
  final Widget icon;
  final Function() onTap;
  final bool? isRoundCorner;

  const SettingItem({
    Key? key,
    required this.title,
    required this.desc,
    required this.icon,
    required this.onTap,
    this.isRoundCorner = true,
  }) : super(key: key);
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(isRoundCorner ?? true ? 16 : 0))),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 4),
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
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

class SettingSwitchItem extends StatelessWidget {
  final String title;
  final String desc;
  final Widget icon;
  final Function() onTap;
  final bool? isRoundCorner;
  final bool isSwitchOn;

  const SettingSwitchItem({
    Key? key,
    required this.title,
    required this.desc,
    required this.icon,
    required this.onTap,
    required this.isSwitchOn,
    this.isRoundCorner = true,
  }) : super(key: key);
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
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(isRoundCorner ?? true ? 16 : 0))),
      child: Container(
        height: 64,
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        alignment: Alignment.centerLeft,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(width: 4),
            icon,
            const SizedBox(width: 12),
            Expanded(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: GoogleFonts.lato(
                      fontSize: 18,
                      fontWeight: FontWeight.w500,
                      color: Colors.black87,
                    ),
                  ),
                  const SizedBox(height: 4),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text(
                        desc,
                        softWrap: true,
                        maxLines: 2,
                        style: GoogleFonts.lato(
                          fontSize: 14,
                          fontWeight: FontWeight.w500,
                          color: Colors.black45,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Switch(
              value: isSwitchOn,
              onChanged: (v) {
                onTap();
              },
            ),
          ],
        ),
      ),
    );
  }
}
