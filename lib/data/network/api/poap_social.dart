import 'package:dio/dio.dart';
import 'package:poapin/data/network/api/constant/poap_social.dart';
import 'package:poapin/data/network/client/dio_poap_social.dart';

class POAPSocialAPI {
  final DioPOAPSocialClient dioClient;

  POAPSocialAPI({required this.dioClient});

  Future<Response> getFollowings(String address) async {
    try {
      final Response response = await dioClient.get(
        POAPSocialConstant.followings(address),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }

  Future<Response> getFollowers(String address) async {
    try {
      final Response response = await dioClient.get(
        POAPSocialConstant.followers(address),
      );
      return response;
    } catch (e) {
      rethrow;
    }
  }
}
