import 'package:dashx_flutter/service.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:uuid/uuid.dart';
import 'dashx_flutter_platform_interface.dart';

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

  Future<void> trackEvent() async {
    getRequest(
        targetEnvironment!, publicKey!, baseUri!,  trackEventClick(uuidValue!));
  }

  Future<void> update() async {}
}
