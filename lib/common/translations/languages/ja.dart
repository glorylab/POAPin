import 'package:poapin/common/translations/strings.dart';

class JaTranslations {
  static Map<String, String> get map => {
        'language_in_english': 'Japanese',
        'language_in_native': '日本語',
        'POAPin': 'POAPin',

        /// Tabs
        Strings.home: 'ホーム',
        Strings.watchlist: 'ウォッチリスト',
        Strings.me: '私',

        /// Home(Initial state)
        Strings.enjoy: 'POAPと一緒に生活を楽しむ',
        Strings.setAddress: 'アドレスを設定して、ホームページでPOAPを表示します',
        Strings.setEthAddress: 'ETHアドレスを設定する',
        Strings.ethAddressOrEns: 'ETHアドレスまたはENS',
        Strings.invalidAddress: '無効なアドレス',

        /// Home(empty)
        Strings.noPoap:
            '現在、あなたにはPOAPがないようです。\nしかし、まだ遅くありません！\n\nPOAPについて学び、POAPを作成してみましょう。',

        /// Home(available)
        Strings.followers: 'フォロワー',
        Strings.followings: 'フォロー中',
        Strings.events: 'イベント',
        Strings.poaps: 'POAPs',
        Strings.growth: '成長',
        Strings.monthly: '毎月',
        Strings.filterHint: '名前、説明、場所などでフィルタリング',
        Strings.visibility: '表示',
        Strings.hideDuplicates: '重複を隠す',
        Strings.showAll: '全て表示',
        Strings.sort: '並び替え',
        Strings.newest: '最新',
        Strings.oldest: '最古',
        Strings.shape: '形状',
        Strings.square: '四角',
        Strings.round: '円形',
        Strings.layout: 'レイアウト',
        Strings.grid: 'グリッド',
        Strings.list: 'リスト',
        Strings.timeline: 'タイムライン',
        Strings.filter: 'フィルタ',
        Strings.filterTitle: 'タイトル',
        Strings.filterDescription: '説明',
        Strings.filterCountry: '国',
        Strings.filterTag: 'タグ',
        Strings.filterChain: 'チェーン',
        Strings.filterClearAll: 'すべてクリア',

        /// Home(edit mode)
        Strings.editMode: 'POAPs編集',
        Strings.editTags: 'タグ編集',
        Strings.newTag: '新しいタグ',
        Strings.newTagHint: '新しいイベントのタグ',

        /// Moments
        Strings.momentsDesc: '''あなたのPOAPコレクションはあなたのデジタルIDです。
        
        それはあなたが誰であるか、どこにいたか、何を達成したか、誰に会ったかを世界に示します。
        
        モーメンツは、POAPに実際のインスタンスを永遠に保存することで、デジタルブックマークに実際の価値を追加する方法です。
        ''',
        Strings.uploadMoments: 'welook.ioにモーメンツをアップロード',

        /// GitPOAP
        Strings.gitPoapDesc:
            '''GitPOAPは、指定された意義深いオープンソースプロジェクトへの貢献を通じてGitPOAPプラットフォームで発行される通常のPOAP（エキストラスピン付き）です。 レポオーナーは、彼らの仕事の認識として自動的にGitPOAPを寄稿者に配布します。
        ''',
        Strings.gitPoapStart: 'POAPinに貢献する',

        /// Watchlist(Initial state)
        Strings.watchlistHint: 'ここに興味のあるアドレスを追加できます。',
        Strings.addCollection: '最初のコレクションを追加',

        /// Watchlist(available)
        Strings.follow: 'フォロー',
        Strings.unfollow: 'フォロー解除',

        /// Me
        Strings.connectWalletHint: 'ブラウザでログインしてウォレットを接続。',

        /// Profile
        Strings.profile: 'プロフィール',
        Strings.dangerZone: '危険区域',
        Strings.deleteAccount: 'アカウントを削除',
        Strings.deleteAccountDesc: 'アカウントを削除してもよろしいですか？\n\nこの操作は元に戻せません。',
        Strings.deleteAccountConfirm: '削除',

        /// Tags
        Strings.tags: 'タグ',
        Strings.manageTags: 'タグを管理',
        Strings.noTags: 'まだタグはありません',
        Strings.addTag: '新しいタグ',
        Strings.editTagHint: '上から選択\nまたは',

        /// Settings
        Strings.settings: '設定',
        Strings.settingsDesc: '通知、データなど',
        Strings.notification: '通知',
        Strings.notificationEmail: 'メール',
        Strings.notificationEmailDesc: 'メール通知を受け取る',
        Strings.notificationApp: 'アプリ',
        Strings.notificationAppDesc: 'アプリの通知を受け取る',
        Strings.notificationAppThisDevice: 'このデバイス',
        Strings.notificationAppDescMore: 'アプリの通知を受け取る',
        Strings.notificationBrowser: 'ブラウザ',
        Strings.notificationBrowserDesc: 'ブラウザの通知を受け取る',
        Strings.notificationPush: 'プッシュ',
        Strings.notificationPushDesc: 'プッシュ通知を受け取る',
        Strings.general: '一般',
        Strings.language: '言語',
        Strings.contributeLanguage: '🙇 他の翻訳を提供する 🔗',
        Strings.data: '一般',
        Strings.cache: 'すべてのキャッシュをクリア',
        Strings.cacheDesc: 'アプリに問題がある場合は、これを試してください。',
        Strings.about: '情報',

        /// Account
        Strings.signIn: 'サインイン',
        Strings.logOut: 'ログアウト',
        Strings.signInApple: 'Appleでサインイン',
        Strings.signInGoogle: 'Googleで続行',
        Strings.tos: '続行することで、利用規約およびプライバシーポリシーに同意したことになります',

        /// Common
        Strings.done: '完了',
        Strings.alert: 'アラート',
        Strings.error: 'エラー',
        Strings.learnMore: 'もっと詳しく知る',
        // --- Months
        Strings.january: '1月',
        Strings.february: '2月',
        Strings.march: '3月',
        Strings.april: '4月',
        Strings.may: '5月',
        Strings.june: '6月',
        Strings.july: '7月',
        Strings.august: '8月',
        Strings.september: '9月',
        Strings.october: '10月',
        Strings.november: '11月',
        Strings.december: '12月',
      };
}
