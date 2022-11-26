import 'add_to_wallets_platform_interface.dart';

class AddToWallets {
  Future<bool?> addToAppleWallet(List<int> bytes) {
    return AddToWalletsPlatform.instance.addToAppleWallet(bytes);
  }

  Future<bool?> addToGoogleWallet(String json) {
    return AddToWalletsPlatform.instance.addToGoogleWallet(json);
  }
}
