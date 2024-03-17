import 'package:get_it/get_it.dart';
import 'package:poapin/data/network/api/gitpoap.dart';
import 'package:poapin/data/network/api/poap.dart';
import 'package:poapin/data/network/api/poap_social.dart';
import 'package:poapin/data/network/api/poapin.dart';
import 'package:poapin/data/network/client/dio_gitpoap.dart';
import 'package:poapin/data/network/client/dio_poap.dart';
import 'package:poapin/data/network/client/dio_poap_social.dart';
import 'package:poapin/data/network/client/dio_poapin.dart';
import 'package:poapin/data/repository/gitpoap_repository.dart';
import 'package:poapin/data/repository/poap_repository.dart';
import 'package:poapin/data/repository/poap_social_repository.dart';
import 'package:poapin/data/repository/poapin_repository.dart';

final getIt = GetIt.instance;

Future<void> setupAPI() async {
  /// POAPin API
  getIt.registerSingleton(DioPOAPINClient());
  getIt.registerSingleton(POAPINAPI(dioClient: getIt<DioPOAPINClient>()));
  getIt.registerSingleton(POAPINRepository(getIt.get<POAPINAPI>()));

  /// POAP API
  getIt.registerSingleton(DioPOAPClient());
  getIt.registerSingleton(POAPAPI(dioClient: getIt<DioPOAPClient>()));
  getIt.registerSingleton(POAPRepository(getIt.get<POAPAPI>()));

  /// POAP Social API
  getIt.registerSingleton(DioPOAPSocialClient());
  getIt.registerSingleton(
      POAPSocialAPI(dioClient: getIt<DioPOAPSocialClient>()));
  getIt.registerSingleton(POAPSocialRepository(getIt.get<POAPSocialAPI>()));

  /// GitPOAP API
  getIt.registerSingleton(DioGitPOAPClient());
  getIt.registerSingleton(GitPOAPApi(dioClient: getIt<DioGitPOAPClient>()));
  getIt.registerSingleton(GitPOAPRepository(getIt.get<GitPOAPApi>()));
}
