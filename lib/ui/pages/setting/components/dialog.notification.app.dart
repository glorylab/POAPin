import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:poapin/common/translations/locale_string.dart';
import 'package:poapin/common/translations/strings.dart';
import 'package:poapin/ui/pages/setting/controller.dart';

class NotificationAppDialog extends StatelessWidget {
  const NotificationAppDialog({
    Key? key,
  }) : super(key: key);

  _buildNotificationList() {
    // Show notification list with toggle button
    return GetBuilder<SettingController>(
      builder: (c) => Container(
        padding: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
        child: ListView.builder(
          itemCount: 3,
          itemBuilder: (context, index) {
            if (index == 0 || index == 2) {
              return Container(
                height: 64,
              );
            }
            // Toggle button inside list tile
            return Container(
              margin: const EdgeInsets.only(top: 16),
              padding: const EdgeInsets.only(bottom: 4),
              child: ListTile(
                selected: c.locale ==
                    LocaleString().getAllLanguage()[index - 1]['locale'],
                selectedTileColor: Colors.green.withOpacity(0.08),
                title: Row(
                  children: [
                    Expanded(
                      child: Text(
                        strNotificationAppThisDevice,
                        style: GoogleFonts.robotoMono(color: Colors.black87),
                      ),
                    ),
                    const SizedBox(
                      width: 16,
                    ),
                    Switch(
                      value: c.notificationOn,
                      onChanged: (value) {
                        c.toggleNotification(value);
                      },
                      activeColor: Colors.green,
                    ),
                  ],
                ),
                minVerticalPadding: 8,
                shape: ContinuousRectangleBorder(
                  borderRadius: BorderRadius.circular(24),
                ),
                onTap: () {
                  c.toggleNotification(!c.notificationOn);
                },
              ),
            );
          },
        ),
      ),
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
          clipBehavior: Clip.antiAlias,
          child: Container(
            constraints: const BoxConstraints(
                maxWidth: 600, minWidth: 320, minHeight: 128, maxHeight: 512),
            child: Stack(
              children: [
                _buildNotificationList(),
                Container(
                  height: 56,
                  padding: const EdgeInsets.symmetric(horizontal: 32),
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
                        strNotificationApp,
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
