import 'dart:developer';

import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'add_to_wallets_platform_interface.dart';

/// An implementation of [AddToWalletsPlatform] that uses method channels.
class MethodChannelAddToWallets extends AddToWalletsPlatform {
  @visibleForTesting
  final methodChannel = const MethodChannel('add_to_wallets');

  @override
  Future<bool?> addToAppleWallet(List<int> bytes) async {
    try {
      final version = await methodChannel.invokeMethod<bool>('addToAppleWallet', {'pass': bytes});
      return version;
    } on PlatformException catch (e) {
      log(e.toString());
      return null;
    }
  }

  @override
  Future<bool?> addToGoogleWallet(String json) async {
    try {
      final version = await methodChannel.invokeMethod<bool>('addToGoogleWallet', {'pass': json});
      return version;
    } on PlatformException catch (e) {
      log(e.toString());
      return null;
    }
  }
}
