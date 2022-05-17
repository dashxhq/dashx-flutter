import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:dashx_flutter/dashx_flutter_method_channel.dart';

void main() {
  MethodChannelDashxFlutter platform = MethodChannelDashxFlutter();
  const MethodChannel channel = MethodChannel('dashx_flutter');

  TestWidgetsFlutterBinding.ensureInitialized();

  setUp(() {
    channel.setMockMethodCallHandler((MethodCall methodCall) async {
      return '42';
    });
  });

  tearDown(() {
    channel.setMockMethodCallHandler(null);
  });

  test('getPlatformVersion', () async {
    expect(await platform.getPlatformVersion(), '42');
  });
}
