#import "AddToWalletsPlugin.h"
#if __has_include(<add_to_wallets/add_to_wallets-Swift.h>)
#import <add_to_wallets/add_to_wallets-Swift.h>
#else
// Support project import fallback if the generated compatibility header
// is not copied when this plugin is created as a library.
// https://forums.swift.org/t/swift-static-libraries-dont-copy-generated-objective-c-header/19816
#import "add_to_wallets-Swift.h"
#endif

@implementation AddToWalletsPlugin
+ (void)registerWithRegistrar:(NSObject<FlutterPluginRegistrar>*)registrar {
  [SwiftAddToWalletsPlugin registerWithRegistrar:registrar];
}
@end
