import 'package:get/get.dart';
import 'package:poapin/common/translations/languages/en_gb.dart';
import 'package:poapin/common/translations/languages/en_us.dart';
import 'package:poapin/common/translations/languages/es.dart';
import 'package:poapin/common/translations/languages/fr.dart';
import 'package:poapin/common/translations/languages/ja.dart';
import 'package:poapin/common/translations/languages/ko.dart';
import 'package:poapin/common/translations/languages/ru.dart';
import 'package:poapin/common/translations/languages/th.dart';
import 'package:poapin/common/translations/languages/tr.dart';
import 'package:poapin/common/translations/languages/uk.dart';
import 'package:poapin/common/translations/languages/vi.dart';
import 'package:poapin/common/translations/languages/zh_cn.dart';
import 'package:poapin/common/translations/languages/zh_hk.dart';
import 'package:poapin/common/translations/languages/zh_tw.dart';

class LocaleString extends Translations {
  @override
  Map<String, Map<String, String>> get keys => {
        'de': JaTranslations.map, // [German](Deutsch)
        'en_GB': EnGBTranslations.map, // [English] - United Kingdom
        'en_US': EnUSTranslations.map, // [English] - United States
        'es': ESTranslations.map, // [Castellano](español)
        'fr': FRTranslations.map, // [French](français)
        'ja': JaTranslations.map, // [Japanese](日本語)
        'ko': KoTranslations.map, // [Korean](한국어)
        'ru': RuTranslations.map, // [Russian](ру́сский)
        'th': ThTranslations.map, // [Thai](ภาษาไทย)
        'tr': TrTranslations.map, // [Turkish](Türkçe)
        'uk': UkTranslations.map, // [Ukrainian](українська)
        'vi': ViTranslations.map, // [Vietnamese](Tiếng Việt)
        'zh_CN': ZhCNTranslations.map, // [Simplified Chinese](简体中文) - China
        'zh_HK':
            ZhHKTranslations.map, // [Traditional Chinese](繁体中文) - Hong Kong
        'zh_TW': ZhTWTranslations.map, // [Traditional Chinese](繁体中文) - Taiwan
      };
}
