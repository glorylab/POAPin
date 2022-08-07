import 'dart:convert';
import 'dart:math';

import 'package:crypto/crypto.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:poapin/data/repository/poapin_repository.dart';
import 'package:poapin/di/service_locator.dart';
import 'package:poapin/ui/controller.base.dart';
import 'package:sign_in_with_apple/sign_in_with_apple.dart';

class AuthController extends BaseController {
  bool isAuthing = false;
  bool isGoogleAuthing = false;
  bool isAppleAuthing = false;

  final poapinRepository = getIt.get<POAPINRepository>();

  @override
  String screenName() {
    return 'Auth';
  }

  void _resetAuthingState() {
    isAuthing = false;
    isGoogleAuthing = false;
    isAppleAuthing = false;
    update();
  }

  String idToken = '';

  Future gm() async {
    poapinRepository.gm();
  }

  Future signInWithGoogle() async {
    isAuthing = true;
    isGoogleAuthing = true;
    isAppleAuthing = false;
    update();
    return _signInWithGoogle().then((data) async {
      // await gm();
      _resetAuthingState();
      return data;
    }).catchError((onError) {
      _resetAuthingState();
      return onError;
    });
  }

  Future signInWithApple() async {
    isAuthing = true;
    isGoogleAuthing = false;
    isAppleAuthing = true;
    update();
    return _signInWithApple().then((data) async {
      _resetAuthingState();
      return data;
    });
  }

  Future<UserCredential> _signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth =
        await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,
    );

    // Once signed in, return the UserCredential
    return await FirebaseAuth.instance
        .signInWithCredential(credential)
        .catchError((onError) {
      if (kDebugMode) {
        print(onError);
      }
      return onError;
    });
  }

  Future<UserCredential> _signInWithApple() async {
    // To prevent replay attacks with the credential returned from Apple, we
    // include a nonce in the credential request. When signing in with
    // Firebase, the nonce in the id token returned by Apple, is expected to
    // match the sha256 hash of `rawNonce`.
    final rawNonce = generateNonce();
    final nonce = sha256ofString(rawNonce);

    // Request credential for the currently signed in Apple account.
    final appleCredential = await SignInWithApple.getAppleIDCredential(
      scopes: [
        AppleIDAuthorizationScopes.email,
        AppleIDAuthorizationScopes.fullName,
      ],
      nonce: nonce,
    );

    // Create an `OAuthCredential` from the credential returned by Apple.
    final oauthCredential = OAuthProvider("apple.com").credential(
      idToken: appleCredential.identityToken,
      rawNonce: rawNonce,
    );

    // Sign in the user with Firebase. If the nonce we generated earlier does
    // not match the nonce in `appleCredential.identityToken`, sign in will fail.
    return await FirebaseAuth.instance.signInWithCredential(oauthCredential);
  }

  /// Generates a cryptographically secure random nonce, to be included in a
  /// credential request.
  String generateNonce([int length = 32]) {
    const charset =
        '0123456789ABCDEFGHIJKLMNOPQRSTUVXYZabcdefghijklmnopqrstuvwxyz-._';
    final random = Random.secure();
    return List.generate(length, (_) => charset[random.nextInt(charset.length)])
        .join();
  }

  /// Returns the sha256 hash of [input] in hex notation.
  String sha256ofString(String input) {
    final bytes = utf8.encode(input);
    final digest = sha256.convert(bytes);
    return digest.toString();
  }
}
