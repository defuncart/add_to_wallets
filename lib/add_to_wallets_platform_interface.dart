import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'add_to_wallets_method_channel.dart';

abstract class AddToWalletsPlatform extends PlatformInterface {
  /// Constructs a AddToWalletsPlatform.
  AddToWalletsPlatform() : super(token: _token);

  static final Object _token = Object();

  static AddToWalletsPlatform _instance = MethodChannelAddToWallets();

  /// The default instance of [AddToWalletsPlatform] to use.
  ///
  /// Defaults to [MethodChannelAddToWallets].
  static AddToWalletsPlatform get instance => _instance;

  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [AddToWalletsPlatform] when
  /// they register themselves.
  static set instance(AddToWalletsPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<bool?> addToAppleWallet(List<int> bytes) {
    throw UnimplementedError('addToAppleWallet() has not been implemented.');
  }

  Future<bool?> addToGoogleWallet(String json) {
    throw UnimplementedError('addToGoogleWallet() has not been implemented.');
  }
}
