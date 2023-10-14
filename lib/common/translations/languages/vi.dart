import 'package:poapin/common/translations/strings.dart';

class ViTranslations {
  static Map<String, String> get map => {
        'language_in_english': 'Vietnamese',
        'language_in_native': 'Tiếng Việt',
        'POAPin': 'POAPin',

        /// Tabs
        Strings.home: 'Trang chủ',
        Strings.watchlist: 'Danh sách theo dõi',
        Strings.me: 'Tôi',

        /// Home(Initial state)
        Strings.enjoy: 'Hưởng thụ cuộc sống với POAP',
        Strings.setAddress:
            'Thiết lập địa chỉ của bạn và bạn sẽ thấy POAPs trên trang chủ',
        Strings.setEthAddress: 'Đặt địa chỉ ETH',
        Strings.ethAddressOrEns: 'Địa chỉ ETH hoặc ENS',
        Strings.invalidAddress: 'Địa chỉ không hợp lệ',

        /// Home(empty)
        Strings.noPoap:
            'Bạn dường như không có POAP nào ngay bây giờ.\nNhưng không phải quá muộn!\n\nBắt đầu tìm hiểu về POAP bằng cách tạo ra một POAP.',

        /// Home(available)
        Strings.followers: 'người theo dõi',
        Strings.followings: 'đang theo dõi',
        Strings.events: 'Sự kiện',
        Strings.poaps: 'POAPs',
        Strings.growth: 'tăng trưởng',
        Strings.monthly: 'hàng tháng',
        Strings.filterHint: 'Lọc theo tên, mô tả, vị trí, v.v.',
        // --- Prefs
        Strings.visibility: 'Khả năng nhìn thấy',
        Strings.hideDuplicates: 'Ẩn bản sao',
        Strings.showAll: 'Hiển thị tất cả',
        Strings.sort: 'Sắp xếp',
        Strings.newest: 'Mới nhất',
        Strings.oldest: 'Cũ nhất',
        Strings.shape: 'Hình dạng',
        Strings.square: 'Vuông',
        Strings.round: 'Tròn',
        Strings.layout: 'Bố cục',
        Strings.grid: 'Lưới',
        Strings.list: 'Danh sách',
        Strings.timeline: 'Dòng thời gian',
        // --- Filter
        Strings.filter: 'Bộ lọc',
        Strings.filterTitle: 'Tiêu đề',
        Strings.filterDescription: 'Mô tả',
        Strings.filterCountry: 'Quốc gia',
        Strings.filterTag: 'Thẻ',
        Strings.filterChain: 'Chuỗi',
        Strings.filterClearAll: 'Xóa tất cả',

        /// Home(edit mode)
        Strings.editMode: 'Chỉnh sửa POAPs',
        Strings.editTags: 'Chỉnh sửa thẻ',
        Strings.newTag: 'Thẻ mới',
        Strings.newTagHint: 'thẻ mới cho sự kiện',

        /// Moments
        Strings.momentsDesc:
            '''Bộ sưu tập POAP của bạn là ID kỹ thuật số của bạn.
        
        Nó cho thế giới biết bạn là ai: nơi bạn đã đến, những gì bạn đã đạt được và ai bạn đã gặp.
        
        Moments là cách để thêm giá trị thực sự cho dấu trang kỹ thuật số của bạn bằng cách lưu trữ những trường hợp trong đời thực trong một POAP, mãi mãi.
        ''',
        Strings.uploadMoments: 'Tải lên những khoảnh khắc trên welook.io',

        /// GitPOAP
        Strings.gitPoapDesc:
            '''Một GitPOAP là một POAP thông thường (với một chút xoay) được khai thác thông qua nền tảng GitPOAP cho các đóng góp có ý nghĩa đặc biệt cho các dự án nguồn mở. Chủ sở hữu Repo tự động phân phối GitPOAPs cho những người đóng góp của họ như một sự công nhận công việc của họ.
        ''',
        Strings.gitPoapStart: 'Đóng góp cho POAPin',

        /// Watchlist(Initial state)
        Strings.watchlistHint:
            'Bạn có thể thêm một số địa chỉ bạn quan tâm ở đây.',
        Strings.addCollection: 'Thêm bộ sưu tập đầu tiên của bạn',

        /// Watchlist(available)
        Strings.follow: 'Theo dõi',
        Strings.unfollow: 'Bỏ theo dõi',

        /// Me
        Strings.connectWalletHint: 'Đăng nhập bằng trình duyệt và kết nối ví.',

        /// Profile
        Strings.profile: 'Hồ sơ',
        Strings.dangerZone: 'Vùng nguy hiểm',
        Strings.deleteAccount: 'Xóa tài khoản',
        Strings.deleteAccountDesc:
            'Bạn có chắc chắn muốn xóa tài khoản của mình?\n\nThao tác này không thể hoàn tác.',
        Strings.deleteAccountConfirm: 'Xóa',

        /// Tags
        Strings.tags: 'Thẻ',
        Strings.manageTags: 'Quản lý thẻ của bạn',
        Strings.noTags: 'Chưa có thẻ',
        Strings.addTag: 'Thêm thẻ mới',
        Strings.editTagHint: 'chọn từ trên\nhoặc',

        /// Settings
        Strings.settings: 'Cài đặt',
        Strings.settingsDesc: 'Thông báo, dữ liệu, v.v.',
        Strings.notification: 'Thông báo',
        Strings.notificationEmail: 'Email',
        Strings.notificationEmailDesc: 'Nhận thông báo qua email',
        Strings.notificationApp: 'Ứng dụng',
        Strings.notificationAppDesc: 'Nhận thông báo từ ứng dụng',
        Strings.notificationAppThisDevice: 'Thiết bị này',
        Strings.notificationAppDescMore: 'Nhận thông báo từ ứng dụng',
        Strings.notificationBrowser: 'Trình duyệt',
        Strings.notificationBrowserDesc: 'Nhận thông báo từ trình duyệt',
        Strings.notificationPush: 'Đẩy',
        Strings.notificationPushDesc: 'Nhận thông báo đẩy',
        Strings.general: 'Chung',
        Strings.language: 'Ngôn ngữ',
        Strings.contributeLanguage: '🙇 Đóng góp thêm bản dịch 🔗',
        Strings.data: 'Dữ liệu',
        Strings.cache: 'Xóa tất cả bộ nhớ cache',
        Strings.cacheDesc: 'Nếu có sự cố với ứng dụng, hãy thử nó.',
        Strings.about: 'Giới thiệu',

        /// Account
        Strings.signIn: 'Đăng nhập',
        Strings.logOut: 'Đăng xuất',
        Strings.signInApple: 'Đăng nhập với Apple',
        Strings.signInGoogle: 'Tiếp tục với Google',
        Strings.tos:
            'Bằng cách tiếp tục, bạn đồng ý với Điều khoản Dịch vụ và Chính sách Bảo mật của chúng tôi',

        /// Common
        Strings.done: 'Hoàn thành',
        Strings.alert: 'Cảnh báo',
        Strings.error: 'Lỗi',
        Strings.learnMore: 'tìm hiểu thêm',
        // --- Months
        Strings.january: 'Tháng Một',
        Strings.february: 'Tháng Hai',
        Strings.march: 'Tháng Ba',
        Strings.april: 'Tháng Tư',
        Strings.may: 'Tháng Năm',
        Strings.june: 'Tháng Sáu',
        Strings.july: 'Tháng Bảy',
        Strings.august: 'Tháng Tám',
        Strings.september: 'Tháng Chín',
        Strings.october: 'Tháng Mười',
        Strings.november: 'Tháng Mười Một',
        Strings.december: 'Tháng Mười Hai',
      };
}
