#import <substrate.h>
#import <Foundation/Foundation.h>

#define PLIST_PATH @"/var/mobile/Library/Preferences/com.watcher.wechatsettings.plist"
/* Get Boolean & int from plist */

inline bool GetPrefBool(NSString *key) {
	return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] boolValue];
}

inline int GetPrefInt(NSString *key) {
	return [[[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key] intValue];
}

%hook WCDeviceStepObject
-(unsigned int)m7StepCount {
  if(GetPrefBool(@"enabled")) { // Your key name here
    int newValue = GetPrefInt(@"key1slider"); // Your key name here
    return newValue;
  } else {
    return %orig;
}
}
-(unsigned int)hkStepCount{
  if(GetPrefBool(@"enabled")) { // Your key name here
    int newValue = GetPrefInt(@"key1slider"); // Your key name here
    return newValue;
  } else {
    return %orig;
}
}
%end
