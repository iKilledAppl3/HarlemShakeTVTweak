#import "HarlemShakeTVTweak_header.h"

/*

  This tweak was created out of boredom and for my good friend David from @thejailbreakhub.
  Copyright 2019 J.K. Hayslip (@iKilledAppl3) & ToxicAppl3 INSDC./iKilledAppl3 LLC.
  December, 29, 2019 was a fun day for us all!
  Anyways enjoy and remember not to spoil yourself!


*/

// the icon class we need to hook it so we can modify it's code! 
%hook HBRootCell
/// Lets modify this method because why not make idle mode useful?
-(void)_enterIdleMode {
  if (kEnabled) { // make the icons dance if it's enabled
    %orig;
  [self setupHarlemShake]; // created a new method so....
  }
  
  else {
    %orig;
  }
}


// new method :P
%new -(void)setupHarlemShake {
  lonerView = self; // self = HBRootCell class :P
    if (!animating) {
  harlemShake = [[VLMHarlemShake alloc] initWithLonerView:lonerView];
  }

  if (animating) {
    return;
  }

  if (lonerView != nil) {
    animating = YES;
  }
  

  [harlemShake shakeWithCompletion:^{ // this will shake the icons view.
    animating = NO;
    harlemShake = nil;
}];
}

%end


// Load preferences to make sure changes are written to the plist
static void loadPrefs() {

  NSMutableDictionary *prefs = [[NSMutableDictionary alloc] initWithContentsOfFile:PLIST_PATH];
  
    //our preference values that write to a plist file when a user selects something
  kEnabled = [([prefs objectForKey:@"kEnabled"] ?: @(NO)) boolValue];
}

// our constructor
// we use this for our preferences call back to see if the user has updated the value or not.
%ctor {
  CFNotificationCenterAddObserver(CFNotificationCenterGetDarwinNotifyCenter(), NULL, (CFNotificationCallback) loadPrefs, CFSTR("com.ikilledappl3.harlemShaketv.prefschanged"), NULL, CFNotificationSuspensionBehaviorDeliverImmediately);
  loadPrefs();
}