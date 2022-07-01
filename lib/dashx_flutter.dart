import 'dart:convert';

import 'package:dashx_flutter/service.dart';
import 'package:http/http.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'dashx_flutter_platform_interface.dart';
import 'dart:io' show Platform;
import 'package:http/http.dart' as http;

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

  Response? responseMessage;
  String? uuidValue;
  String? deviceToken;
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

  Future<void> identify() async {
    getRequest(
        targetEnvironment!, publicKey!, baseUri!, identifyAccount(uuidValue!));
  }

  Future<void> register(Map<String, dynamic> body) async {
    String url = 'https://node.dashxdemo.com/register';
    Uri uri = Uri.parse(url);

    Response response = await http.post(uri,
        headers: <String, String>{
          'Content-Type': 'application/json; charset=UTF-8',
        },
        body: jsonEncode(body));
        print(response.body);
      responseMessage = response;
  }

// use this function to check responses of all http requests.
  Response? response() {
    if (responseMessage != null) {
      responseMessage;
    }
    return null;
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
    String device = "WEB";
    if (Platform.isAndroid) {
      device = "ANDROID";
    } else if (Platform.isIOS) {
      device = "IOS";
    }
    getRequest(targetEnvironment!, publicKey!, baseUri!,
        subscribeContact(uuidValue!, deviceToken!, device));
  }

  Future<void> update() async {}
}
