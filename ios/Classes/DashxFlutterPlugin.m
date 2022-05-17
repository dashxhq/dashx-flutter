#import "DashxFlutterPlugin.h"
#if __has_include(<dashx_flutter/dashx_flutter-Swift.h>)
#import <dashx_flutter/dashx_flutter-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "dashx_flutter-Swift.h"
#endif

@implementation DashxFlutterPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftDashxFlutterPlugin registerWithRegistrar:registrar];
}
@end
