import 'package:poapin/common/translations/strings.dart';

class ThTranslations {
  static Map<String, String> get map => {
        'language_in_english': 'Thai',
        'language_in_native': 'ภาษาไทย',
        'POAPin': 'POAPin',

        /// Tabs
        Strings.home: 'บ้าน',
        Strings.watchlist: 'รายการที่สนใจ',
        Strings.me: 'ฉัน',

        /// Home(Initial state)
        Strings.enjoy: 'สนุกไปกับชีวิตพร้อม POAP',
        Strings.setAddress:
            'ตั้งค่าที่อยู่ของคุณและคุณจะเห็น POAPs ของคุณในหน้าหลัก',
        Strings.setEthAddress: 'ตั้งค่าที่อยู่ ETH',
        Strings.ethAddressOrEns: 'ที่อยู่ ETH หรือ ENS',
        Strings.invalidAddress: 'ที่อยู่ไม่ถูกต้อง',

        /// Home(empty)
        Strings.noPoap:
            'คุณไม่มี POAP ในขณะนี้\nแต่ยังไม่สายเกินไป!\n\nเริ่มเรียนรู้เกี่ยวกับ POAP โดยการสร้าง POAP',

        /// Home(available)
        Strings.followers: 'ผู้ติดตาม',
        Strings.followings: 'กำลังติดตาม',
        Strings.events: 'เหตุการณ์',
        Strings.poaps: 'POAPs',
        Strings.growth: 'การเติบโต',
        Strings.monthly: 'รายเดือน',
        Strings.filterHint: 'กรองตามชื่อ, คำอธิบาย, ที่ตั้ง, ฯลฯ',
        // --- Prefs
        Strings.visibility: 'ทัศนวิสัย',
        Strings.hideDuplicates: 'ซ่อนรายการซ้ำ',
        Strings.showAll: 'แสดงทั้งหมด',
        Strings.sort: 'เรียงลำดับ',
        Strings.newest: 'ใหม่ที่สุด',
        Strings.oldest: 'เก่าที่สุด',
        Strings.shape: 'รูปร่าง',
        Strings.square: 'สี่เหลี่ยม',
        Strings.round: 'วงกลม',
        Strings.layout: 'การจัดรูปแบบ',
        Strings.grid: 'กริด',
        Strings.list: 'รายการ',
        Strings.timeline: 'เส้นเวลา',
        // --- Filter
        Strings.filter: 'กรอง',
        Strings.filterTitle: 'หัวข้อ',
        Strings.filterDescription: 'คำอธิบาย',
        Strings.filterCountry: 'ประเทศ',
        Strings.filterTag: 'แท็ก',
        Strings.filterChain: 'เชื่อมโยง',
        Strings.filterClearAll: 'ล้างทั้งหมด',

        /// Home(edit mode)
        Strings.editMode: 'แก้ไข POAPs',
        Strings.editTags: 'แก้ไขแท็ก',
        Strings.newTag: 'แท็กใหม่',
        Strings.newTagHint: 'แท็กใหม่สำหรับเหตุการณ์',

        /// Moments
        Strings.momentsDesc: '''คอลเล็กชัน POAP ของคุณคือ ID ดิจิทัลของคุณ.

        มันแสดงให้โลกเห็นว่าคุณคือใคร: คุณไปที่ไหน, คุณทำสิ่งที่ทำได้และคุณพบกับใคร.
        
        Moments เป็นวิธีเพิ่มคุณค่าจริงๆ ให้กับบุ๊กมาร์กดิจิทัลของคุณโดยการบันทึกเหตุการณ์ในชีวิตจริงใน POAP, ตลอดไป.
        ''',
        Strings.uploadMoments: 'อัปโหลดวินาทีที่ welook.io',

        /// GitPOAP
        Strings.gitPoapDesc:
            '''GitPOAP คือ POAP ปกติ (พร้อมการหมุนเพิ่มเติม) ที่ถูกสร้างผ่านแพลตฟอร์ม GitPOAP สำหรับการสนับสนุนที่มีความหมายต่อโปรเจคโอเพ่นซอร์ส. เจ้าของ Repo จะแจก GitPOAPs ให้กับผู้สนับสนุนของพวกเขาเพื่อเป็นการรับรู้การทำงานของพวกเขา.
        ''',
        Strings.gitPoapStart: 'สนับสนุน POAPin',

        /// Watchlist(Initial state)
        Strings.watchlistHint: 'คุณสามารถเพิ่มที่อยู่ที่คุณสนใจได้ที่นี่.',
        Strings.addCollection: 'เพิ่มคอลเล็กชันแรกของคุณ',

        /// Watchlist(available)
        Strings.follow: 'ติดตาม',
        Strings.unfollow: 'เลิกติดตาม',

        /// Me
        Strings.connectWalletHint:
            'ลงชื่อเข้าใช้ด้วยเบราว์เซอร์และเชื่อมต่อกระเป๋าเงิน.',

        /// Profile
        Strings.profile: 'โปรไฟล์',
        Strings.dangerZone: 'โซนอันตราย',
        Strings.deleteAccount: 'ลบบัญชี',
        Strings.deleteAccountDesc:
            'คุณแน่ใจหรือว่าต้องการลบบัญชีของคุณ?\n\nการดำเนินการนี้ไม่สามารถยกเลิกได้.',
        Strings.deleteAccountConfirm: 'ลบ',

        /// Tags
        Strings.tags: 'แท็ก',
        Strings.manageTags: 'จัดการแท็กของคุณ',
        Strings.noTags: 'ยังไม่มีแท็ก',
        Strings.addTag: 'แท็กใหม่',
        Strings.editTagHint: 'เลือกจากด้านบน\nหรือ',

        /// Journal
        // Strings.journal: 'Journal',

        /// Settings
        Strings.settings: 'การตั้งค่า',
        Strings.settingsDesc: 'การแจ้งเตือน, ข้อมูล, ฯลฯ',
        Strings.notification: 'การแจ้งเตือน',
        Strings.notificationEmail: 'อีเมล',
        Strings.notificationEmailDesc: 'รับการแจ้งเตือนทางอีเมล',
        Strings.notificationApp: 'แอพ',
        Strings.notificationAppDesc: 'รับการแจ้งเตือนจากแอพ',
        Strings.notificationAppThisDevice: 'อุปกรณ์นี้',
        Strings.notificationAppDescMore: 'รับการแจ้งเตือนจากแอพ',
        Strings.notificationBrowser: 'เบราว์เซอร์',
        Strings.notificationBrowserDesc: 'รับการแจ้งเตือนทางเบราว์เซอร์',
        Strings.notificationPush: 'การแจ้งเตือน push',
        Strings.notificationPushDesc: 'รับการแจ้งเตือน push',
        Strings.general: 'ทั่วไป',
        Strings.language: 'ภาษา',
        Strings.contributeLanguage: '🙇 สนับสนุนการแปลเพิ่มเติม 🔗',
        Strings.data: 'ข้อมูลทั่วไป',
        Strings.cache: 'ล้างแคชทั้งหมด',
        Strings.cacheDesc: 'หากมีปัญหากับแอพ, โปรดลอง.',
        Strings.about: 'เกี่ยวกับ',

        /// Account
        Strings.signIn: 'ลงชื่อเข้าใช้',
        Strings.logOut: 'ออกจากระบบ',
        Strings.signInApple: 'ลงชื่อเข้าใช้ด้วย Apple',
        Strings.signInGoogle: 'ดำเนินการต่อด้วย Google',
        Strings.tos:
            'ด้วยการดำเนินการต่อ, คุณยอมรับข้อกำหนดในการให้บริการและนโยบายความเป็นส่วนตัวของเรา',

        /// Common
        Strings.done: 'เสร็จสิ้น',
        Strings.alert: 'แจ้งเตือน',
        Strings.error: 'ข้อผิดพลาด',
        Strings.learnMore: 'เรียนรู้เพิ่มเติม',
        // --- Months
        Strings.january: 'มกราคม',
        Strings.february: 'กุมภาพันธ์',
        Strings.march: 'มีนาคม',
        Strings.april: 'เมษายน',
        Strings.may: 'พฤษภาคม',
        Strings.june: 'มิถุนายน',
        Strings.july: 'กรกฎาคม',
        Strings.august: 'สิงหาคม',
        Strings.september: 'กันยายน',
        Strings.october: 'ตุลาคม',
        Strings.november: 'พฤศจิกายน',
        Strings.december: 'ธันวาคม',
      };
}
