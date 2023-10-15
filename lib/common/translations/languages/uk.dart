import 'package:poapin/common/translations/strings.dart';

class UkTranslations {
  static Map<String, String> get map => {
        'language_in_english': 'Ukrainian',
        'language_in_native': 'Українська',
        'POAPin': 'POAPin',

        /// Tabs
        Strings.home: 'Дома',
        Strings.watchlist: 'Список спостереження',
        Strings.me: 'Я',

        /// Home(Initial state)
        Strings.enjoy: 'Насолоджуйтесь життям з POAP',
        Strings.setAddress:
            'Встановіть свою адресу і ви побачите свої POAP на домашній сторінці',
        Strings.setEthAddress: 'Встановити адресу ETH',
        Strings.ethAddressOrEns: 'ETH адреса або ENS',
        Strings.invalidAddress: 'Недійсна адреса',

        /// Home(empty)
        Strings.noPoap:
            'Здається, у вас зараз немає жодного POAP.\nАле ще не пізно!\n\nПочніть дізнаватися про POAP, створивши POAP.',

        /// Home(available)
        Strings.followers: 'підписники',
        Strings.followings: 'слідує',
        Strings.events: 'Події',
        Strings.poaps: 'POAPs',
        Strings.growth: 'рост',
        Strings.monthly: 'щомісяця',
        Strings.filterHint: 'Фільтруйте за назвою, описом, місцем тощо.',
        Strings.visibility: 'Видимість',
        Strings.hideDuplicates: 'Приховати дублікати',
        Strings.showAll: 'Показати все',
        Strings.sort: 'Сортувати',
        Strings.newest: 'Найновіші',
        Strings.oldest: 'Найстаріші',
        Strings.shape: 'Форма',
        Strings.square: 'Квадрат',
        Strings.round: 'Круг',
        Strings.layout: 'Макет',
        Strings.grid: 'Сітка',
        Strings.list: 'Список',
        Strings.timeline: 'Хронологія',
        Strings.filter: 'Фільтр',
        Strings.filterTitle: 'Назва',
        Strings.filterDescription: 'Опис',
        Strings.filterCountry: 'Країна',
        Strings.filterTag: 'Тег',
        Strings.filterChain: 'Ланцюг',
        Strings.filterClearAll: 'Очистити все',

        /// Home(edit mode)
        Strings.editMode: 'Редагувати POAPs',
        Strings.editTags: 'Редагувати теги',
        Strings.newTag: 'Новий тег',
        Strings.newTagHint: 'новий тег для події',

        /// Moments
        Strings.momentsDesc: '''Ваша колекція POAP - це ваша цифрова ID.

        Вона показує світові, хто ви: де ви були, що ви досягли та кого ви зустріли.

        Moments - це спосіб додати справжнє значення до вашої цифрової закладки, зберігаючи реальні випадки в POAP назавжди.
        ''',
        Strings.uploadMoments: 'Завантажте моменти на welook.io',

        /// GitPOAP
        Strings.gitPoapDesc:
            '''GitPOAP - це звичайний POAP (з додатковим обертом), який відбивається через платформу GitPOAP для визначеного значущого внеску в відкриті джерела проектів. Власники Repo автоматично розподіляють GitPOAP між своїми учасниками як визнання їхньої роботи.
        ''',
        Strings.gitPoapStart: 'Внесіть внесок до POAPin',

        /// Watchlist(Initial state)
        Strings.watchlistHint:
            'Ви можете додати декілька адрес, які вас цікавлять, тут.',
        Strings.addCollection: 'Додати свою першу колекцію',

        /// Watchlist(available)
        Strings.follow: 'Слідкуйте',
        Strings.unfollow: 'Відписатись',

        /// Me
        Strings.connectWalletHint:
            'Увійдіть у систему з браузера та підключіть гаманець.',

        /// Profile
        Strings.profile: 'Профіль',
        Strings.dangerZone: 'Небезпечна зона',
        Strings.deleteAccount: 'Видалити акаунт',
        Strings.deleteAccountDesc:
            'Ви впевнені, що хочете видалити свій акаунт?\n\nЦю операцію не можна скасувати.',
        Strings.deleteAccountConfirm: 'Видалити',

        /// Tags
        Strings.tags: 'Теги',
        Strings.manageTags: 'Управляйте своїми тегами',
        Strings.noTags: 'Тегів ще немає',
        Strings.addTag: 'Новий тег',
        Strings.editTagHint: 'виберіть зверху\nабо',

        /// Journal
        // Strings.journal: 'Journal',

        /// Settings
        Strings.settings: 'Налаштування',
        Strings.settingsDesc: 'Сповіщення, дані, тощо.',
        Strings.notification: 'Сповіщення',
        Strings.notificationEmail: 'Електронна пошта',
        Strings.notificationEmailDesc:
            'Отримуйте сповіщення електронною поштою',
        Strings.notificationApp: 'Додаток',
        Strings.notificationAppDesc: 'Отримуйте сповіщення в додатку',
        Strings.notificationAppThisDevice: 'Цей пристрій',
        Strings.notificationAppDescMore: 'Отримуйте сповіщення в додатку',
        Strings.notificationBrowser: 'Браузер',
        Strings.notificationBrowserDesc: 'Отримуйте сповіщення в браузері',
        Strings.notificationPush: 'Push',
        Strings.notificationPushDesc: 'Отримуйте push сповіщення',
        Strings.general: 'Загальні',
        Strings.language: 'Мова',
        Strings.contributeLanguage: '🙇 Внесіть більше перекладів 🔗',
        Strings.data: 'Загальні',
        Strings.cache: 'Очистити весь кеш',
        Strings.cacheDesc: 'Якщо у вас є проблеми з додатком, спробуйте це.',
        Strings.about: 'Про додаток',

        /// Account
        Strings.signIn: 'Увійти',
        Strings.logOut: 'Вийти',
        Strings.signInApple: 'Увійти через Apple',
        Strings.signInGoogle: 'Продовжити з Google',
        Strings.tos:
            'Продовжуючи, ви погоджуєтесь з нашими Умовами обслуговування та Політикою конфіденційності',

        /// Common
        Strings.done: 'Готово',
        Strings.alert: 'Сповіщення',
        Strings.error: 'Помилка',
        Strings.learnMore: 'дізнатися більше',

        /// Months
        Strings.january: 'Січень',
        Strings.february: 'Лютий',
        Strings.march: 'Березень',
        Strings.april: 'Квітень',
        Strings.may: 'Травень',
        Strings.june: 'Червень',
        Strings.july: 'Липень',
        Strings.august: 'Серпень',
        Strings.september: 'Вересень',
        Strings.october: 'Жовтень',
        Strings.november: 'Листопад',
        Strings.december: 'Грудень',
      };
}
