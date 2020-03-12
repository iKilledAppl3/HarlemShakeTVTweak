#include "iKAHarlemShakePrefsRootListController.h"

/*

	This tweak was created out of boredom and for my good friend David from @thejailbreakhub.
	Copyright 2019 J.K. Hayslip (@iKilledAppl3) & ToxicAppl3 INSDC./iKilledAppl3 LLC.
	December, 29, 2019 was a fun day for us all!
	Anyways enjoy and remember not to spoil yourself!
	tvOS preferences are fun! aren't they? lol 


*/

@implementation iKAHarlemShakePrefsRootListController

inline NSString *GetPrefVal(NSString *key){
    return [[NSDictionary dictionaryWithContentsOfFile:PLIST_PATH] valueForKey:key];
}


// Lets load our prefs!
- (id)loadSettingGroups {
    
    id facade = [[NSClassFromString(@"TVSettingsPreferenceFacade") alloc] initWithDomain:@"com.ikilledappl3.harlemshaketv" notifyChanges:TRUE];
    
    NSMutableArray *_backingArray = [NSMutableArray new];
    
    kEnabled = [TSKSettingItem toggleItemWithTitle:@"Enable Tweak" description:@"Do the Harlem Shake! \n When your screen goes idle your icons will dance!" representedObject:facade keyPath:@"kEnabled" onTitle:@"Enabled" offTitle:@"Disabled"];
    
    
    // Respring Button here baby! No documenation found so I had to figure this one out myself :P
    kRespringButton = [TSKSettingItem actionItemWithTitle:@"Respring" description:@"Apply Changes with a Respring! \n © Copyright 2019 J.K. Hayslip (iKilledAppl3) & ToxicAppl3 INSDC/iKilledAppl3 LLC." representedObject:facade keyPath:PLIST_PATH target:self action:@selector(doAFancyRespring)];
    
    
    TSKSettingGroup *group = [TSKSettingGroup groupWithTitle:@"Enable Tweak" settingItems:@[kEnabled]];
    
    
    TSKSettingGroup *group2 = [TSKSettingGroup groupWithTitle:@"Apply Changes" settingItems:@[kRespringButton]];
    
    [_backingArray addObject:group];
    [_backingArray addObject:group2];
    
    [self setValue:_backingArray forKey:@"_settingGroups"];
    
    return _backingArray;
    
}


// lets blur the screen before we respring the apple tv! Well chop down wood that is :P
-(void)doAFancyRespring {
    self.mainAppRootWindow = [UIApplication sharedApplication].keyWindow;
    self.respringBlur = [UIBlurEffect effectWithStyle:UIBlurEffectStyleDark];
    self.respringEffectView = [[UIVisualEffectView alloc] initWithEffect:self.respringBlur];
    self.respringEffectView.frame = [[UIScreen mainScreen] bounds];
    [self.mainAppRootWindow addSubview:self.respringEffectView];
    [UIView beginAnimations:nil context:NULL];
    [UIView setAnimationDuration:5.0];
    [self.respringEffectView setAlpha:0];
    [UIView commitAnimations];
    [self performSelector:@selector(respring) withObject:nil afterDelay:3.0];

}

-(void)respring {
    NSTask *task = [[[NSTask alloc] init] autorelease];
    [task setLaunchPath:@"/usr/bin/killall"];
    [task setArguments:[NSArray arrayWithObjects:@"PineBoard", nil]];
    [task launch];
    
}

// this is to make sure our preferences our loaded
- (TVSPreferences *)ourPreferences {
    return [TVSPreferences preferencesWithDomain:@"com.ikilledappl3.harlemshaketv"];
}


// This is to show our preferences in the tweaks section of tvOS.
- (void)showViewController:(TSKSettingItem *)item {
    TSKTextInputViewController *testObject = [[TSKTextInputViewController alloc] init];
    
    testObject.headerText = @"HarlemShakeTV";
    testObject.initialText = [[self ourPreferences] stringForKey:item.keyPath];
    
    if ([testObject respondsToSelector:@selector(setEditingDelegate:)]){
        [testObject setEditingDelegate:self];
    }
    [testObject setEditingItem:item];
    [self.navigationController pushViewController:testObject animated:TRUE];
}

- (void)editingController:(id)arg1 didCancelForSettingItem:(TSKSettingItem *)arg2 {
    [super editingController:arg1 didCancelForSettingItem:arg2];
}
- (void)editingController:(id)arg1 didProvideValue:(id)arg2 forSettingItem:(TSKSettingItem *)arg3 {
    [super editingController:arg1 didProvideValue:arg2 forSettingItem:arg3];
    
    TVSPreferences *prefs = [TVSPreferences preferencesWithDomain:@"com.ikilledappl3.harlemshaketv"];
    
    [prefs setObject:arg2 forKey:arg3.keyPath];
    [prefs synchronize];
    
}


// This is to show our tweak's icon instead of the boring Apple TV logo :)
-(id)previewForItemAtIndexPath:(NSIndexPath *)indexPath {
    
    TSKPreviewViewController *item = [super previewForItemAtIndexPath:indexPath];
    
    NSString *imagePath = [[NSBundle bundleForClass:self.class] pathForResource:@"HarlemShakeTV-Header" ofType:@"png"];
    UIImage *icon = [UIImage imageWithContentsOfFile:imagePath];
    if (icon != nil) {
        TSKVibrantImageView *imageView = [[TSKVibrantImageView alloc] initWithImage:icon];
        [item setContentView:imageView];
        
    }
    
    return item;
    
}


@end
