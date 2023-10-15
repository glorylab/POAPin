import 'package:poapin/common/translations/strings.dart';

class TrTranslations {
  static Map<String, String> get map => {
        'language_in_english': 'Turkish',
        'language_in_native': 'Türkçe',
        'POAPin': 'POAPin',

        /// Tabs
        Strings.home: 'Anasayfa',
        Strings.watchlist: 'İzleme listesi',
        Strings.me: 'Ben',

        /// Home(Initial state)
        Strings.enjoy: 'POAP ile hayatın tadını çıkarın',
        Strings.setAddress:
            'Adresinizi ayarlayın ve POAP\'larınızı ana sayfada göreceksiniz',
        Strings.setEthAddress: 'ETH adresini ayarla',
        Strings.ethAddressOrEns: 'ETH adresi veya ENS',
        Strings.invalidAddress: 'Geçersiz adres',

        /// Home(empty)
        Strings.noPoap:
            'Şu anda hiç POAP\'ınız yok gibi görünüyor.\nAma hala geç değil!\n\nPOAP hakkında bilgi edinmeye başlayın ve bir POAP oluşturun.',

        /// Home(available)
        Strings.followers: 'takipçiler',
        Strings.followings: 'takip edilenler',
        Strings.events: 'Etkinlikler',
        Strings.poaps: 'POAPs',
        Strings.growth: 'büyüme',
        Strings.monthly: 'aylık',
        Strings.filterHint: 'Ad, açıklama, konum vb. ile filtreleyin.',
        // --- Prefs
        Strings.visibility: 'Görünürlük',
        Strings.hideDuplicates: 'Yinelenenleri Gizle',
        Strings.showAll: 'Hepsini göster',
        Strings.sort: 'Sırala',
        Strings.newest: 'En yeni',
        Strings.oldest: 'En eski',
        Strings.shape: 'Şekil',
        Strings.square: 'Kare',
        Strings.round: 'Yuvarlak',
        Strings.layout: 'Düzen',
        Strings.grid: 'Izgara',
        Strings.list: 'Liste',
        Strings.timeline: 'Zaman çizelgesi',
        // --- Filter
        Strings.filter: 'Filtre',
        Strings.filterTitle: 'Başlık',
        Strings.filterDescription: 'Açıklama',
        Strings.filterCountry: 'Ülke',
        Strings.filterTag: 'Etiket',
        Strings.filterChain: 'Zincir',
        Strings.filterClearAll: 'Tümünü Temizle',

        /// Home(edit mode)
        Strings.editMode: 'POAP\'ları Düzenle',
        Strings.editTags: 'Etiketleri düzenle',
        Strings.newTag: 'Yeni Etiket',
        Strings.newTagHint: 'etkinlik için yeni etiket',

        /// Moments
        Strings.momentsDesc: '''POAP koleksiyonunuz dijital kimliğinizdir.
        
        Dünyaya kim olduğunuzu gösterir: nerede bulunduğunuzu, ne başardığınızı ve kiminle tanıştığınızı.
        
        Anlar, gerçek yaşam anlarını bir POAP'ta sonsuza dek kaydetme şeklinde dijital yer iminize gerçek değer katmanın bir yoludur.
        ''',
        Strings.uploadMoments: 'Anları welook.io üzerine yükle',

        /// GitPOAP
        Strings.gitPoapDesc:
            '''Bir GitPOAP, belirli anlamlı açık kaynak projelerine katkı sağlama için GitPOAP platformu üzerinden basılan normal bir POAP'tır (ekstra bir dönüş ile). Repo sahipleri, katkıda bulunanların çalışmalarını tanımak için otomatik olarak GitPOAP'ları dağıtır.
        ''',
        Strings.gitPoapStart: 'POAPin\'e katkıda bulun',

        /// Watchlist(Initial state)
        Strings.watchlistHint:
            'Buraya ilgilendiğiniz bazı adresleri ekleyebilirsiniz.',
        Strings.addCollection: 'İlk koleksiyonunuzu ekleyin',

        /// Watchlist(available)
        Strings.follow: 'Takip et',
        Strings.unfollow: 'Takibi bırak',

        /// Me
        Strings.connectWalletHint:
            'Tarayıcıyla oturum açın & cüzdanı bağlayın.',

        /// Profile
        Strings.profile: 'Profil',
        Strings.dangerZone: 'Tehlike Bölgesi',
        Strings.deleteAccount: 'Hesabı sil',
        Strings.deleteAccountDesc:
            'Hesabınızı silmek istediğinizden emin misiniz?\n\nBu işlem geri alınamaz.',
        Strings.deleteAccountConfirm: 'Sil',

        /// Tags
        Strings.tags: 'Etiketler',
        Strings.manageTags: 'Etiketlerinizi yönetin',
        Strings.noTags: 'Henüz etiket yok',
        Strings.addTag: 'Yeni Etiket',
        Strings.editTagHint: 'yukarıdan seçin\nveya',

        /// Journal
        // Strings.journal: 'Journal',

        /// Settings
        Strings.settings: 'Ayarlar',
        Strings.settingsDesc: 'Bildirimler, veriler, vb.',
        Strings.notification: 'Bildirim',
        Strings.notificationEmail: 'E-posta',
        Strings.notificationEmailDesc: 'E-posta bildirimleri al',
        Strings.notificationApp: 'Uygulama',
        Strings.notificationAppDesc: 'Uygulama bildirimleri al',
        Strings.notificationAppThisDevice: 'Bu cihaz',
        Strings.notificationAppDescMore: 'Uygulama bildirimleri al',
        Strings.notificationBrowser: 'Tarayıcı',
        Strings.notificationBrowserDesc: 'Tarayıcı bildirimleri al',
        Strings.notificationPush: 'Push',
        Strings.notificationPushDesc: 'Push bildirimleri al',
        Strings.general: 'Genel',
        Strings.language: 'Dil',
        Strings.contributeLanguage: '🙇 Daha fazla çeviri katkıda bulunun 🔗',
        Strings.data: 'Genel',
        Strings.cache: 'Tüm önbelleği temizle',
        Strings.cacheDesc: 'Uygulamada problemler varsa, lütfen bunu deneyin.',
        Strings.about: 'Hakkında',

        /// Account
        Strings.signIn: 'Oturum aç',
        Strings.logOut: 'Oturumu kapat',
        Strings.signInApple: 'Apple ile oturum aç',
        Strings.signInGoogle: 'Google ile devam et',
        Strings.tos:
            'Devam ederek, Hizmet Şartlarımızı ve Gizlilik Politikamızı kabul etmiş olursunuz',

        /// Common
        Strings.done: 'Tamamlandı',
        Strings.alert: 'Uyarı',
        Strings.error: 'Hata',
        Strings.learnMore: 'daha fazla öğren',
        // --- Months
        Strings.january: 'Ocak',
        Strings.february: 'Şubat',
        Strings.march: 'Mart',
        Strings.april: 'Nisan',
        Strings.may: 'Mayıs',
        Strings.june: 'Haziran',
        Strings.july: 'Temmuz',
        Strings.august: 'Ağustos',
        Strings.september: 'Eylül',
        Strings.october: 'Ekim',
        Strings.november: 'Kasım',
        Strings.december: 'Aralık',
      };
}
