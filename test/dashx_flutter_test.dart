import 'package:flutter_test/flutter_test.dart';
import 'package:dashx_flutter/dashx_flutter.dart';
import 'package:dashx_flutter/dashx_flutter_platform_interface.dart';
import 'package:dashx_flutter/dashx_flutter_method_channel.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

class MockDashxFlutterPlatform 
    with MockPlatformInterfaceMixin
    implements DashxFlutterPlatform {

  @override
  Future<String?> getPlatformVersion() => Future.value('42');
}

void main() {
  final DashxFlutterPlatform initialPlatform = DashxFlutterPlatform.instance;

  test('$MethodChannelDashxFlutter is the default instance', () {
    expect(initialPlatform, isInstanceOf<MethodChannelDashxFlutter>());
  });

  test('getPlatformVersion', () async {
    DashxFlutter dashxFlutterPlugin = DashxFlutter();
    MockDashxFlutterPlatform fakePlatform = MockDashxFlutterPlatform();
    DashxFlutterPlatform.instance = fakePlatform;
  
    expect(await dashxFlutterPlugin.getPlatformVersion(), '42');
  });
}
