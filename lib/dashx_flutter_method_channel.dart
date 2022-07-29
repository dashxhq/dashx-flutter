import 'package:dashx_flutter/dashx_flutter.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/services.dart';

import 'dashx_flutter_platform_interface.dart';

/// An implementation of [DashXPlatform] that uses method channels.
class MethodChannelDashxFlutter extends DashXPlatform {
  /// The method channel used to interact with the native platform.
  @visibleForTesting
  final methodChannel = const MethodChannel('dashx_flutter');

  Future<void> setConfig(Map<String, String?> config) async {
    return methodChannel.invokeMethod('setConfig', config);
  }
}
