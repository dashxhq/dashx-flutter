import 'package:dashx_flutter/dashx_flutter.dart';
import 'package:plugin_platform_interface/plugin_platform_interface.dart';

import 'dashx_flutter_method_channel.dart';

abstract class DashXPlatform extends PlatformInterface {
  /// Constructs a DashXPlatform.
  DashXPlatform() : super(token: _token);

  static final Object _token = Object();

  static DashXPlatform _instance = MethodChannelDashxFlutter();

  /// The default instance of [DashXPlatform] to use.
  ///
  /// Defaults to [MethodChannelDashxFlutter].
  static DashXPlatform get instance => _instance;
  
  /// Platform-specific implementations should set this with their own
  /// platform-specific class that extends [DashXPlatform] when
  /// they register themselves.
  static set instance(DashXPlatform instance) {
    PlatformInterface.verifyToken(instance, _token);
    _instance = instance;
  }

  Future<DashX> getDashX() {
    throw UnimplementedError('platformVersion() has not been implemented.');
  }
}
