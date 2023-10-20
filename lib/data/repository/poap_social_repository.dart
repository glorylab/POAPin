import 'package:dio/dio.dart';
import 'package:poapin/data/network/api/poap_social.dart';
import 'package:poapin/data/network/exceptions.dart';

class POAPSocialRepository {
  final POAPSocialAPI poapSocialAPI;

  POAPSocialRepository(this.poapSocialAPI);

  Future<List<String>> getFollowings(String address) async {
    try {
      final response = await poapSocialAPI.getFollowings(address);
      if (response.statusCode == 200) {
        final followings =
            (response.data as List).map((f) => f.toString()).toList();
        return followings;
      }
      return [];
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }

  Future<List<String>> getFollowers(String address) async {
    try {
      final response = await poapSocialAPI.getFollowers(address);
      if (response.statusCode == 200) {
        final followings =
            (response.data as List).map((f) => f.toString()).toList();
        return followings;
      }
      return [];
    } on DioException catch (e) {
      final errorMessage = DioExceptions.fromDioError(e).toString();
      throw errorMessage;
    }
  }
}
