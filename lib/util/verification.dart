import 'package:ens_dart/ens_dart.dart';

class VerificationHelper {
  static bool isETH(String address) {
    RegExp eth = RegExp(r'^0x[0-9a-fA-F]{40}$');
    return eth.hasMatch(address.toLowerCase());
  }

  static bool isENS(String address) {
    RegExp ens = RegExp(
        r'[-a-zA-Z0-9@:%._\+~#=]{1,256}\.[a-zA-Z0-9()]{1,6}\b([-a-zA-Z0-9()@:%_\+.~#?&//=]*)?');
    return ens.hasMatch(address.toLowerCase());
  }

  // static bool isENS(String address) {
  //   RegExp ens = RegExp(r'^((?!\.).)*\.eth$');
  //   return ens.hasMatch(address.toLowerCase());
  // }

  static bool isEmail(String address) {
    RegExp email = RegExp(r'^[a-zA-Z0-9.]+@[a-zA-Z0-9]+\.[a-zA-Z]+');
    return email.hasMatch(address.toLowerCase());
  }

  static Future getEthAndEns(Ens client, String address) async {
    String ethAddress;
    String ensName;
    if (VerificationHelper.isENS(address)) {
      ensName = address;
      ethAddress = await getETHbyENS(client, address);
    } else if (VerificationHelper.isETH(address)) {
      ethAddress = address;
      ensName = await getENSbyETH(client, ethAddress).then((value) {
        return value;
      }).catchError((e) {
        return '';
      });
    } else {
      return ['', ''];
    }
    return [ethAddress, ensName];
  }

  static Future getENSbyETH(Ens client, String eth) {
    Future<String> ensName = Future.value('');
    try {
      ensName = client.withAddress(eth).getName();
      return ensName;
    } catch (e) {
      return ensName;
    }
  }

  static Future getETHbyENS(Ens client, String ens) {
    return client.withName(ens).getAddress().then((address) {
      return address.hex;
    });
  }
}
