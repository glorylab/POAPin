import 'package:poapin/common/translations/strings.dart';

class KoTranslations {
  static Map<String, String> get map => {
        'language_in_english': 'Korean',
        'language_in_native': '한국어',
        'POAPin': 'POAPin',

        /// Tabs
        Strings.home: '홈',
        Strings.watchlist: '관심 목록',
        Strings.me: '나',

        /// Home(Initial state)
        Strings.enjoy: 'POAP와 함께 생활 즐기기',
        Strings.setAddress: '주소를 설정하면 홈페이지에서 POAP를 볼 수 있습니다',
        Strings.setEthAddress: 'ETH 주소 설정',
        Strings.ethAddressOrEns: 'ETH 주소 또는 ENS',
        Strings.invalidAddress: '잘못된 주소',

        /// Home(empty)
        Strings.noPOAP:
            '현재 POAP가 없는 것 같습니다.\n하지만 아직 늦지 않았습니다!\n\nPOAP 만들기를 통해 POAP에 대해 배우기 시작하세요.',

        /// Home(available)
        Strings.followers: '팔로워',
        Strings.followings: '팔로잉',
        Strings.events: '이벤트',
        Strings.poaps: 'POAPs',
        Strings.growth: '성장',
        Strings.monthly: '월간',
        Strings.filterHint: '이름, 설명, 위치 등으로 필터링',
        // --- Prefs
        Strings.visibility: '가시성',
        Strings.hideDuplicates: '중복 숨기기',
        Strings.showAll: '모두 보기',
        Strings.sort: '정렬',
        Strings.newest: '가장 최신',
        Strings.oldest: '가장 오래된',
        Strings.shape: '모양',
        Strings.square: '사각형',
        Strings.round: '원형',
        Strings.layout: '레이아웃',
        Strings.grid: '그리드',
        Strings.list: '목록',
        Strings.timeline: '타임라인',
        // --- Filter
        Strings.filter: '필터',
        Strings.filterTitle: '제목',
        Strings.filterDescription: '설명',
        Strings.filterCountry: '국가',
        Strings.filterTag: '태그',
        Strings.filterChain: '체인',
        Strings.filterClearAll: '모두 지우기',

        /// Home(edit mode)
        Strings.editMode: 'POAP 편집',
        Strings.editTags: '태그 편집',
        Strings.newTag: '새로운 태그',
        Strings.newTagHint: '이벤트에 대한 새로운 태그',

        /// Moments
        Strings.momentsDesc: '''귀하의 POAP 컬렉션은 귀하의 디지털 ID입니다.
    
    이는 세계에 당신이 누구인지, 어디에 있었는지, 무엇을 이루었는지, 누구를 만났는지 보여줍니다.
    
    Moments는 POAP에 실제 인스턴스를 영원히 저장하여 디지털 북마크에 실제 가치를 추가하는 방법입니다.
    ''',
        Strings.uploadMoments: 'welook.io에 순간 업로드',

        /// GitPOAP
        Strings.gitPOAPDesc:
            '''GitPOAP는 GitPOAP 플랫폼을 통해 지정된 의미있는 오픈 소스 프로젝트 기여를 위해 생성된 일반 POAP(추가 스핀 포함)입니다. Repo 소유자들은 그들의 작업을 인식으로써 자동적으로 GitPOAP를 기여자에게 분배합니다.
    ''',
        Strings.gitPOAPStart: 'POAPin에 기여하기',

        /// Watchlist(Initial state)
        Strings.watchlistHint: '여기에 관심이 있는 몇 가지 주소를 추가할 수 있습니다.',
        Strings.addCollection: '첫 번째 컬렉션 추가',

        /// Watchlist(available)
        Strings.follow: '팔로우',
        Strings.unfollow: '언팔로우',

        /// Me
        Strings.connectWalletHint: '브라우저로 로그인하고 지갑 연결.',

        /// Profile
        Strings.profile: '프로필',
        Strings.dangerZone: '위험 지역',
        Strings.deleteAccount: '계정 삭제',
        Strings.deleteAccountDesc: '정말 계정을 삭제하시겠습니까?\n\n이 작업은 취소할 수 없습니다.',
        Strings.deleteAccountConfirm: '삭제',

        /// Tags
        Strings.tags: '태그',
        Strings.manageTags: '태그 관리',
        Strings.noTags: '아직 태그 없음',
        Strings.addTag: '새 태그',
        Strings.editTagHint: '위에서 선택\n또는',

        /// Settings
        Strings.settings: '설정',
        Strings.settingsDesc: '알림, 데이터 등',
        Strings.notification: '알림',
        Strings.notificationEmail: '이메일',
        Strings.notificationEmailDesc: '이메일 알림 받기',
        Strings.notificationApp: '앱',
        Strings.notificationAppDesc: '앱 알림 받기',
        Strings.notificationAppThisDevice: '이 기기',
        Strings.notificationAppDescMore: '앱 알림 받기',
        Strings.notificationBrowser: '브라우저',
        Strings.notificationBrowserDesc: '브라우저 알림 받기',
        Strings.notificationPush: '푸시',
        Strings.notificationPushDesc: '푸시 알림 받기',
        Strings.general: '일반',
        Strings.language: '언어',
        Strings.contributeLanguage: '🙇 번역에 더 기여하기 🔗',
        Strings.data: '일반',
        Strings.cache: '모든 캐시 지우기',
        Strings.cacheDesc: '앱에 문제가 있으면 이를 시도해 보세요.',
        Strings.about: '소개',

        /// Account
        Strings.signIn: '로그인',
        Strings.logOut: '로그아웃',
        Strings.signinApple: '애플로 로그인',
        Strings.signinGoogle: '구글로 계속',
        Strings.tos: '계속하면 당사의 이용 약관 및 개인정보 보호 정책에 동의하는 것입니다.',

        /// Common
        Strings.done: '완료',
        Strings.alert: '알림',
        Strings.error: '오류',
        Strings.learnMore: '더 알아보기',
        // --- Months
        Strings.january: '1월',
        Strings.february: '2월',
        Strings.march: '3월',
        Strings.april: '4월',
        Strings.may: '5월',
        Strings.june: '6월',
        Strings.july: '7월',
        Strings.august: '8월',
        Strings.september: '9월',
        Strings.october: '10월',
        Strings.november: '11월',
        Strings.december: '12월',
      };
}
