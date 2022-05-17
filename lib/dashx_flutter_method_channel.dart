import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dashx_flutter_platform_interface.dart';

/// An implementation of [DashxFlutterPlatform] that uses method channels.
class MethodChannelDashxFlutter extends DashxFlutterPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dashx_flutter');

  @override
  Future<String?> getPlatformVersion() async {
    final version = await methodChannel.invokeMethod<String>('getPlatformVersion');
    return version;
  }
}
