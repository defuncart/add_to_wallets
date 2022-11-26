import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:add_to_wallets/add_to_wallets.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:uuid/uuid.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _addToWalletsPlugin = AddToWallets();
  late Uint8List _iOSPass;
  bool _isLoaded = false;
  // Taken from https://codelabs.developers.google.com/add-to-wallet-android
  static const issuerEmail = '';
  static const issuerId = '';
  static const passClass = '';
  static final passId = const Uuid().v4();
  final _androidPass = '''
    {
      "iss": "$issuerEmail",
      "aud": "google",
      "typ": "savetowallet",
      "iat": "${DateTime.now().toIso8601String()}",
      "origins": [],
      "payload": {
        "genericObjects": [
          {
            "id": "$issuerId.$passId",
            "classId": "$passClass",
            "genericType": "GENERIC_TYPE_UNSPECIFIED",
            "hexBackgroundColor": "#4285f4",
            "logo": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/pass_google_logo.jpg"
              }
            },
            "cardTitle": {
              "defaultValue": {
                "language": "en",
                "value": "Google I/O '22  [DEMO ONLY]"
              }
            },
            "subheader": {
              "defaultValue": {
                "language": "en",
                "value": "Attendee"
              }
            },
            "header": {
              "defaultValue": {
                "language": "en",
                "value": "Alex McJacobs"
              }
            },
            "barcode": {
              "type": "QR_CODE",
              "value": "$passId"
            },
            "heroImage": {
              "sourceUri": {
                "uri": "https://storage.googleapis.com/wallet-lab-tools-codelab-artifacts-public/google-io-hero-demo-only.jpg"
              }
            },
            "textModulesData": [
              {
                "header": "POINTS",
                "body": "${Random().nextInt(9999)}",
                "id": "points"
              },
              {
                "header": "CONTACTS",
                "body": "${Random().nextInt(99) + 1}",
                "id": "contacts"
              }
            ]
          }
        ]
      }
    }
    ''';

  @override
  void initState() {
    super.initState();
    initPlatformState();
  }

  // Platform messages are asynchronous, so we initialize in an async method.
  Future<void> initPlatformState() async {
    _iOSPass = await _passProvider();
    setState(() => _isLoaded = true);

    // If the widget was removed from the tree while the asynchronous platform
    // message was in flight, we want to discard the reply rather than calling
    // setState to update our non-existent appearance.
    if (!mounted) return;
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Plugin example app'),
        ),
        body: Center(
          child: _isLoaded
              ? ElevatedButton(
                  onPressed: () async {
                    if (Platform.isAndroid) {
                      await _addToWalletsPlugin.addToGoogleWallet(_androidPass);
                    } else if (Platform.isIOS) {
                      await _addToWalletsPlugin.addToAppleWallet(_iOSPass);
                    }
                  },
                  child: const Text('Add to Wallet'),
                )
              : const SizedBox.shrink(),
        ),
      ),
    );
  }

// Taken from https://github.com/barkibu/add_to_wallet
  Future<Uint8List> _passProvider() async {
    ByteData pass = await rootBundle.load('assets/health_id_card_sample.pkpass');
    return pass.buffer.asUint8List();
  }
}
