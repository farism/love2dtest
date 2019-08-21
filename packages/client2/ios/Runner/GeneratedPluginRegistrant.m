//
//  Generated file. Do not edit.
//

#import "GeneratedPluginRegistrant.h"
#import <shared_preferences/SharedPreferencesPlugin.h>
#import <shared_preferences_fde/SharedPreferencesPlugin.h>
#import <url_launcher/UrlLauncherPlugin.h>
#import <url_launcher_fde/UrlLauncherPlugin.h>
#import <window_size/WindowSizePlugin.h>

@implementation GeneratedPluginRegistrant

+ (void)registerWithRegistry:(NSObject<FlutterPluginRegistry>*)registry {
  [FLTSharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTSharedPreferencesPlugin"]];
  [SharedPreferencesPlugin registerWithRegistrar:[registry registrarForPlugin:@"SharedPreferencesPlugin"]];
  [FLTUrlLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"FLTUrlLauncherPlugin"]];
  [UrlLauncherPlugin registerWithRegistrar:[registry registrarForPlugin:@"UrlLauncherPlugin"]];
  [WindowSizePlugin registerWithRegistrar:[registry registrarForPlugin:@"WindowSizePlugin"]];
}

@end
