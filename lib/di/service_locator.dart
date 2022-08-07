import 'package:get_it/get_it.dart';
import 'package:poapin/data/network/api/gitpoap.dart';
import 'package:poapin/data/network/api/poap.dart';
import 'package:poapin/data/network/api/poapin.dart';
import 'package:poapin/data/network/api/welook.dart';
import 'package:poapin/data/network/client/dio_gitpoap.dart';
import 'package:poapin/data/network/client/dio_poap.dart';
import 'package:poapin/data/network/client/dio_poapin.dart';
import 'package:poapin/data/network/client/dio_welook.dart';
import 'package:poapin/data/repository/gitpoap_repository.dart';
import 'package:poapin/data/repository/poap_repository.dart';
import 'package:poapin/data/repository/poapin_repository.dart';
import 'package:poapin/data/repository/welook_repository.dart';

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

  /// GitPOAP API
  getIt.registerSingleton(DioGitPOAPClient());
  getIt.registerSingleton(GitPOAPApi(dioClient: getIt<DioGitPOAPClient>()));
  getIt.registerSingleton(GitPOAPRepository(getIt.get<GitPOAPApi>()));

  /// Welook API
  getIt.registerSingleton(DioWelookClient());
  getIt.registerSingleton(WelookApi(dioClient: getIt<DioWelookClient>()));
  getIt.registerSingleton(WelookRepository(getIt.get<WelookApi>()));
}
