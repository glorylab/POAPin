part of 'pages.dart';

abstract class AppRoutes {
  static const dashboard = '/dashboard';
  static const home = '/home';
  static const journal = '/journal';
  static const watchlist = '/watchlist';
  static const moments = '/moments';
  static const moment = '/moments/:id';
  static const gitpoaps = '/gitpoaps';
  static const square = '/square';
  static const me = '/me';
  static const tags = '/tags';
  static const setting = '/setting';
  static const profile = '/profile';
  static const scanAddress = '/scan/:address';
  static const detail = '/poap/:id';
  static const eventDetail = '/event/:id';
  static const tagDetail = '/tag/:id';
  static const notFound = '/404';
  static const app = '/app';
}
