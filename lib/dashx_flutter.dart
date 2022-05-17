
import 'dashx_flutter_platform_interface.dart';

class DashxFlutter {
  Future<String?> getPlatformVersion() {
    return DashxFlutterPlatform.instance.getPlatformVersion();
  }
}
