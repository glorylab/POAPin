import 'package:get/get.dart';
import 'package:poapin/ui/pages/app/binding.dart';
import 'package:poapin/ui/pages/app/page.dart';
import 'package:poapin/ui/pages/collection/binding.dart';
import 'package:poapin/ui/pages/collection/page.dart';
import 'package:poapin/ui/pages/dashboard/binding.dart';
import 'package:poapin/ui/pages/dashboard/page.dart';
import 'package:poapin/ui/pages/detail/binding.dart';
import 'package:poapin/ui/pages/detail/page.dart';
import 'package:poapin/ui/pages/event/binding.dart';
import 'package:poapin/ui/pages/event/page.dart';
import 'package:poapin/ui/pages/home/binding.dart';
import 'package:poapin/ui/pages/home/page.dart';
import 'package:poapin/ui/pages/me/binding.dart';
import 'package:poapin/ui/pages/me/page.dart';
import 'package:poapin/ui/pages/not_found/page.dart';
import 'package:poapin/ui/pages/profile/binding.dart';
import 'package:poapin/ui/pages/profile/page.dart';
import 'package:poapin/ui/pages/setting/binding.dart';
import 'package:poapin/ui/pages/setting/page.dart';
import 'package:poapin/ui/pages/square/binding.dart';
import 'package:poapin/ui/pages/square/page.dart';
import 'package:poapin/ui/pages/tag/binding.dart';
import 'package:poapin/ui/pages/tag/page.dart';
import 'package:poapin/ui/pages/tags/binding.dart';
import 'package:poapin/ui/pages/tags/page.dart';
import 'package:poapin/ui/pages/watchlist/binding.dart';
import 'package:poapin/ui/pages/watchlist/page.dart';

part 'routes.dart';

class AppPages {
  static const initial = AppRoutes.dashboard;

  static final unknownRoute = GetPage(
    name: AppRoutes.notFound,
    page: () => const NotFoundPage(),
  );

  static final routes = [
    GetPage(
      name: AppRoutes.dashboard,
      page: () => const DashboardPage(),
      binding: DashboardBinding(),
    ),
    GetPage(
      name: AppRoutes.home,
      page: () => const HomePage(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: AppRoutes.watchlist,
      page: () => const WatchlistPage(),
      binding: WatchlistBinding(),
    ),
    GetPage(
      name: AppRoutes.square,
      page: () => const SquarePage(),
      binding: SquareBinding(),
    ),
    GetPage(
      name: AppRoutes.me,
      page: () => const MePage(),
      binding: MeBinding(),
    ),
    GetPage(
      name: AppRoutes.scanAddress,
      page: () => const CollectionPage(),
      binding: CollectionBinding(),
    ),
    GetPage(
      name: AppRoutes.detail,
      page: () => const DetailPage(),
      binding: DetailBinding(),
    ),
    GetPage(
      name: AppRoutes.eventDetail,
      page: () => const EventDetailPage(),
      binding: EventDetailBinding(),
    ),
    GetPage(
      name: AppRoutes.setting,
      page: () => const SettingPage(),
      binding: SettingBinding(),
    ),
    GetPage(
      name: AppRoutes.profile,
      page: () => const ProfilePage(),
      binding: ProfileBinding(),
    ),
    GetPage(
      name: AppRoutes.tags,
      page: () => const TagsPage(),
      binding: TagsBinding(),
    ),
    GetPage(
      name: AppRoutes.tagDetail,
      page: () => const TagPage(),
      binding: TagBinding(),
    ),
    GetPage(
      name: AppRoutes.app,
      page: () => const APPPage(),
      binding: APPBinding(),
    ),
  ];
}
