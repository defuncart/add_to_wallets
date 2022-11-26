import 'package:add_to_wallets/add_to_wallets_method_channel.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  MethodChannelAddToWallets platform = MethodChannelAddToWallets();
  const MethodChannel channel = MethodChannel('add_to_wallets');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return true;
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.addToAppleWallet([]), isTrue);
    expect(await platform.addToGoogleWallet(""), isTrue);
  });
}
