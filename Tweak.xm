#import <substrate.h>
#import <Foundation/Foundation.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.watcher.wechatsettings.plist"
static BOOL enabled = NO;
static int footStepNumber = 0;
/* Get Boolean & int from plist */
static void loadPrefs() {
  NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
  if (prefs) {
    enabled = ([[prefs objectForKey:@"enabled"] boolValue] ? [[prefs objectForKey:@"enabled"] boolValue] : enabled);
    footStepNumber = ([[prefs objectForKey:@"footStepNumber"] floatValue] ?: footStepNumber);
  }
  [prefs release];
}


%hook WCDeviceStepObject
-(unsigned int)m7StepCount {
  if(enabled) { // Your key name here
    int newValue = footStepNumber; // Your key name here
    return newValue;
  } else {
    return %orig;
}
}
-(unsigned int)hkStepCount{
  if(enabled) { // Your key name here
    int newValue = footStepNumber; // Your key name here
    return newValue;
  } else {
    return %orig;
}
}
%end


%ctor {
  loadPrefs();
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback)loadPrefs, CFSTR("com.watcher.wechatsettings/changed"), NULL, CFNotificationSuspensionBehaviorCoalesce);

}
