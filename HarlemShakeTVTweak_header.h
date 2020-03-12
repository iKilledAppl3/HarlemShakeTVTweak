//headers we need! 
#import <UIKit/UIKit.h>
#import "VLMHarlemShake.h"

/*

	This tweak was created out of boredom and for my good friend David from @thejailbreakhub.
	Copyright 2019 J.K. Hayslip (@iKilledAppl3) & ToxicAppl3 INSDC./iKilledAppl3 LLC.
	December, 29, 2019 was a fun day for us all!
	Anyways enjoy and remember not to spoil yourself!


*/


// Make sure our path is specified so our tweak knows where to store all of the settings :)
#define PLIST_PATH @"/var/mobile/Library/Preferences/com.ikilledappl3.harlemshaketv.plist"

//BOOL value that is stored if tweak was enabled.
BOOL kEnabled;

// Apple classes we need so the tweak knows what's up
@interface HBAppGridView : UIView
@end

 @interface HBAppGridViewController : UIViewController 
 @property (nonatomic,retain) UIAlertController *editingAlertController;
 @property (nonatomic,retain) UIView *headerView;
 @property (nonatomic,retain) HBAppGridView *appGridView;    
 -(void)viewDidAppear:(BOOL)arg1;
 -(void)loadView;
 -(void)viewDidLoad;
 @end

 @interface _TVImageStackView : UIStackView
 @end

 @interface _UIStackedImageContainerView : UIView
 @end 

 @interface HBImageStackCollectionViewCell : UICollectionViewCell
 @property (nonatomic,retain) _TVImageStackView * imageStackView;
 @property (nonatomic,retain) _UIStackedImageContainerView * layeredImageView;
 @property (nonatomic,retain) UIView * overlayView; 
 @property (getter=_isPressed,nonatomic,readonly) BOOL pressed;  
 -(BOOL)_isPressed;

// new 
  -(void)setupHarlemShake;

 @end

 @interface HBRootCell : HBImageStackCollectionViewCell
 -(UIView *)icon;
 -(void)setIcon:(id)arg1;
 -(void)_enterIdleMode;
 @end 

 // set these as static so we can call upon them at any time in the tweak!
 VLMHarlemShake *harlemShake; // Harlem Shake class
 UIView *lonerView; // a nil UIView that we tell VLMHarlemShake what view to start shaking first!
 BOOL animating; // is the tweak in action? I.e. is it animating?
 HBRootCell *rootCell; // the icon root view "shrug"....