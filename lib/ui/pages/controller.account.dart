import 'package:get/get.dart';
import 'package:poapin/data/models/account.dart';

class AccountController extends GetxController {
  final address = ''.obs;
  final account = Account.empty().obs;
}
