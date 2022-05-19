import 'dashx_flutter_platform_interface.dart';

class DashXPlugin {
  Future<DashX> get dashX async => await DashXPlatform.instance.getDashX();
}

class DashX {
  final String? baseUri;
  final String? publicKey;
  final String? targetEnvironment;

  DashX({
    required this.baseUri,
    required this.publicKey,
    required this.targetEnvironment,
  });

  Future<DashX> getDashX() {
    return DashXPlatform.instance.getDashX();
  }

  Future<void> identify() async {
    print('inside identify');
  }

  Future<void> update() async {}
}
