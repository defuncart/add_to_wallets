import 'package:add_to_wallets/add_to_wallets.dart';
import 'package:add_to_wallets/add_to_wallets_method_channel.dart';
import 'package:add_to_wallets/add_to_wallets_platform_interface.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockAddToWalletsPlatform with MockPlatformInterfaceMixin implements AddToWalletsPlatform {
  @override
  Future<bool?> addToAppleWallet(List<int> bytes) => Future.value(true);

  @override
  Future<bool?> addToGoogleWallet(String json) => Future.value(true);
}

void main() {
  final AddToWalletsPlatform initialPlatform = AddToWalletsPlatform.instance;

  test('$MethodChannelAddToWallets is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelAddToWallets>());
  });

  test('getPlatformVersion', () async {
    AddToWallets addToWalletsPlugin = AddToWallets();
    MockAddToWalletsPlatform fakePlatform = MockAddToWalletsPlatform();
    AddToWalletsPlatform.instance = fakePlatform;

    expect(await addToWalletsPlugin.addToAppleWallet([]), isTrue);
    expect(await addToWalletsPlugin.addToGoogleWallet(""), isTrue);
  });
}
