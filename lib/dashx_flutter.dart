import 'package:dashx_flutter/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'dashx_flutter_platform_interface.dart';
import 'dart:io' show Platform;

import 'mutation_strings.dart';

class DashXPlugin {
  Future<DashX> get dashX async => await DashXPlatform.instance.getDashX();
}

class DashX {
  final String? publicKey;
  final String? baseUri;
  final String? targetEnvironment;

  DashX({
    required this.publicKey,
    this.baseUri,
    this.targetEnvironment,
  });

  Future<DashX> getDashX() {
    return DashXPlatform.instance.getDashX();
  }

  String? uuidValue;
  String? deviceToken;
  String? device;

  // all http request is happening using this url only
  String urlString = 'https://node.dashxdemo.com';

  Future<String> getUuid() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString('uuid') != null) {
      uuidValue = prefs.getString('uuid');
    } else {
      uuidValue = const Uuid().v4();
      prefs.setString('uuid', uuidValue!);
    }
    print(uuidValue);
    return uuidValue!;
  }

  Future<void> initialize() async {
    await getUuid();
    device = "Unknown";
    if (Platform.isAndroid) {
      device = "ANDROID";
    } else if (Platform.isIOS) {
      device = "IOS";
    }
    Map<String, String?> config = {
      'publicKey': publicKey,
      'baseUri': baseUri,
      'targetEnvironment': targetEnvironment,
      'uid': uuidValue,
      'targetInstallation': device
    };
    DashXPlatform.instance.setConfig(config);
  }

  Future<void> identify() async {
    getRequest(
        targetEnvironment!, publicKey!, baseUri!, identifyAccount(uuidValue!));
  }

  Future<void> track(String event, Map<String, dynamic> jsonData) async {
    getRequest(targetEnvironment!, publicKey!, baseUri!,
        trackEvent(uuidValue!, event, jsonData));
  }

  Future<void> setIdentity(String uid, String token) async {
    getRequest(targetEnvironment!, publicKey!, baseUri!,
        setIdentityAccount(uid, token));
  }

  Future<void> subscribe() async {
    getRequest(targetEnvironment!, publicKey!, baseUri!,
        subscribeContact(uuidValue!, deviceToken!, device!));
  }

  Future<void> update() async {}
}
