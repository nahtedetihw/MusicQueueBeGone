#import "Tweak.h"

#define bundlePath ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/"] ? @"/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/" : @"/var/jb/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/")

BOOL enabled;
HBPreferences *preferences;
NSInteger feedbackStyle;
NSInteger ringStyle;

static void feedbackcall() {
    UIImpactFeedbackGenerator * feedback = [[UIImpactFeedbackGenerator alloc] initWithStyle:(int)feedbackStyle];
    [feedback prepare];
    [feedback impactOccurred];
}

%hook _UINotificationFeedbackGeneratorConfiguration
- (BOOL)defaultEnabled {
    if (enabled) return NO;
    return %orig;
}
%end

// iOS 16.5
%hook _TtCC11MusicCoreUI15NoticePresenterP33_D8FBFBA4851A241D976DAD2E389878C120UIRootViewController
- (void)viewDidLoad {
    if (enabled) {
        if (@available(iOS 13, *)) {
            switch (feedbackStyle) {
                case 0:
                    feedbackStyle = UIImpactFeedbackStyleLight;
                    feedbackcall();
                    break;
                    
                case 1:
                    feedbackStyle = UIImpactFeedbackStyleMedium;
                    feedbackcall();
                    break;
                    
                case 2:
                    feedbackStyle = UIImpactFeedbackStyleHeavy;
                    feedbackcall();
                    break;
                    
                case 3:
                    break;
                    
                default:
                    break;
            }
        } else {
            switch (feedbackStyle) {
                case 0:
                    AudioServicesPlaySystemSound(1519);
                    break;
                    
                case 1:
                    AudioServicesPlaySystemSound(1520);
                    break;
                    
                case 2:
                    AudioServicesPlaySystemSound(1521);
                    break;
                    
                case 3:
                    break;
                    
                default:
                    break;
            }
        }
        
        NSURL *focusIconURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@focus_change_app_icon.caf", bundlePath]];
        
        NSURL *focusKeyboardURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@focus_change_keyboard.caf", bundlePath]];
        
        NSURL *focusLargeURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@focus_change_large.caf", bundlePath]];
        
        NSURL *focusSmallURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@focus_change_small.caf", bundlePath]];
        
        switch (ringStyle) {
            case 0:
                SystemSoundID focusIcon;
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)focusIconURL,&focusIcon);
                AudioServicesPlaySystemSoundWithCompletion(focusIcon, ^{
                    AudioServicesDisposeSystemSoundID(focusIcon);
                });
                break;
                
            case 1:
                SystemSoundID focusKeyboard;
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)focusKeyboardURL,&focusKeyboard);
                AudioServicesPlaySystemSoundWithCompletion(focusKeyboard, ^{
                    AudioServicesDisposeSystemSoundID(focusKeyboard);
                });
                break;
                
            case 2:
                SystemSoundID focusLarge;
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)focusLargeURL,&focusLarge);
                AudioServicesPlaySystemSoundWithCompletion(focusLarge, ^{
                    AudioServicesDisposeSystemSoundID(focusLarge);
                });
                break;
                
            case 3:
                SystemSoundID focusSmall;
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)focusSmallURL,&focusSmall);
                AudioServicesPlaySystemSoundWithCompletion(focusSmall, ^{
                    AudioServicesDisposeSystemSoundID(focusSmall);
                });
                break;
                
            case 4:
                break;
                
            default:
                break;
        }
    } else {
        %orig;
    }
}
%end

// iOS 13 - 16.4
%hook _TtCC16MusicApplication31ContextActionsHUDViewController
- (void)viewDidLoad {
    if (enabled) {
        if (@available(iOS 13, *)) {
            switch (feedbackStyle) {
                case 0:
                    feedbackStyle = UIImpactFeedbackStyleLight;
                    feedbackcall();
                    break;
                    
                case 1:
                    feedbackStyle = UIImpactFeedbackStyleMedium;
                    feedbackcall();
                    break;
                    
                case 2:
                    feedbackStyle = UIImpactFeedbackStyleHeavy;
                    feedbackcall();
                    break;
                    
                case 3:
                    break;
                    
                default:
                    break;
            }
        } else {
            switch (feedbackStyle) {
                case 0:
                    AudioServicesPlaySystemSound(1519);
                    break;
                    
                case 1:
                    AudioServicesPlaySystemSound(1520);
                    break;
                    
                case 2:
                    AudioServicesPlaySystemSound(1521);
                    break;
                    
                case 3:
                    break;
                    
                default:
                    break;
            }
        }
        
        NSURL *focusIconURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@focus_change_app_icon.caf", bundlePath]];
        
        NSURL *focusKeyboardURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@focus_change_keyboard.caf", bundlePath]];
        
        NSURL *focusLargeURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@focus_change_large.caf", bundlePath]];
        
        NSURL *focusSmallURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@focus_change_small.caf", bundlePath]];
        
        switch (ringStyle) {
            case 0:
                SystemSoundID focusIcon;
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)focusIconURL,&focusIcon);
                AudioServicesPlaySystemSoundWithCompletion(focusIcon, ^{
                    AudioServicesDisposeSystemSoundID(focusIcon);
                });
                break;
                
            case 1:
                SystemSoundID focusKeyboard;
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)focusKeyboardURL,&focusKeyboard);
                AudioServicesPlaySystemSoundWithCompletion(focusKeyboard, ^{
                    AudioServicesDisposeSystemSoundID(focusKeyboard);
                });
                break;
                
            case 2:
                SystemSoundID focusLarge;
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)focusLargeURL,&focusLarge);
                AudioServicesPlaySystemSoundWithCompletion(focusLarge, ^{
                    AudioServicesDisposeSystemSoundID(focusLarge);
                });
                break;
                
            case 3:
                SystemSoundID focusSmall;
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)focusSmallURL,&focusSmall);
                AudioServicesPlaySystemSoundWithCompletion(focusSmall, ^{
                    AudioServicesDisposeSystemSoundID(focusSmall);
                });
                break;
                
            case 4:
                break;
                
            default:
                break;
        }
    } else {
        %orig;
    }
}
%end

//iOS 12
%hook _TtC5Music31ContextActionsHUDViewController
- (void)viewDidLoad {
    if (enabled) {
        switch (feedbackStyle) {
            case 0:
                feedbackStyle = UIImpactFeedbackStyleLight;
                feedbackcall();
                break;
                
            case 1:
                feedbackStyle = UIImpactFeedbackStyleMedium;
                feedbackcall();
                break;
                
            case 2:
                feedbackStyle = UIImpactFeedbackStyleHeavy;
                feedbackcall();
                break;
                
            case 3:
                break;
                
            default:
                break;
        }
        
        NSURL *focusIconURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@focus_change_app_icon.caf", bundlePath]];
        
        NSURL *focusKeyboardURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@focus_change_keyboard.caf", bundlePath]];
        
        NSURL *focusLargeURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@focus_change_large.caf", bundlePath]];
        
        NSURL *focusSmallURL = [NSURL URLWithString:[NSString stringWithFormat:@"%@focus_change_small.caf", bundlePath]];
        
        switch (ringStyle) {
            case 0:
                SystemSoundID focusIcon;
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)focusIconURL,&focusIcon);
                AudioServicesPlaySystemSoundWithCompletion(focusIcon, ^{
                    AudioServicesDisposeSystemSoundID(focusIcon);
                });
                break;
                
            case 1:
                SystemSoundID focusKeyboard;
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)focusKeyboardURL,&focusKeyboard);
                AudioServicesPlaySystemSoundWithCompletion(focusKeyboard, ^{
                    AudioServicesDisposeSystemSoundID(focusKeyboard);
                });
                break;
                
            case 2:
                SystemSoundID focusLarge;
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)focusLargeURL,&focusLarge);
                AudioServicesPlaySystemSoundWithCompletion(focusLarge, ^{
                    AudioServicesDisposeSystemSoundID(focusLarge);
                });
                break;
                
            case 3:
                SystemSoundID focusSmall;
                AudioServicesCreateSystemSoundID((__bridge CFURLRef)focusSmallURL,&focusSmall);
                AudioServicesPlaySystemSoundWithCompletion(focusSmall, ^{
                    AudioServicesDisposeSystemSoundID(focusSmall);
                });
                break;
                
            case 4:
                break;
                
            default:
                break;
        }
    } else {
        %orig;
    }
}
%end


%ctor {
    preferences = [[HBPreferences alloc] initWithIdentifier:@"com.nahtedetihw.musicqueuebegoneprefs"];
    [preferences registerBool:&enabled default:YES forKey:@"enabled"];
    [preferences registerInteger:&feedbackStyle default:0 forKey:@"feedbackStyle"];
    [preferences registerInteger:&ringStyle default:0 forKey:@"ringStyle"];
}
