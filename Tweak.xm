#import "Tweak.h"

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

    if (enabled) {
    
    return NO;
    
    }
    
    return %orig;
    
}

%end

%hook MusicQueueBeGone // MusicQueueBeGone iOS 13

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
    
            NSURL *focusIconURL = [NSURL URLWithString:@"/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/focus_change_app_icon.caf"];
            
            NSURL *focusKeyboardURL = [NSURL URLWithString:@"/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/focus_change_keyboard.caf"];
            
            NSURL *focusLargeURL = [NSURL URLWithString:@"/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/focus_change_large.caf"];
            
            NSURL *focusSmallURL = [NSURL URLWithString:@"/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/focus_change_small.caf"];
            
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
    
    }
    
    else {
    
        %orig;
    
    }
        
}

%end

//iOS 12 Support
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
    
            NSURL *focusIconURL = [NSURL URLWithString:@"/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/focus_change_app_icon.caf"];
            
            NSURL *focusKeyboardURL = [NSURL URLWithString:@"/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/focus_change_keyboard.caf"];
            
            NSURL *focusLargeURL = [NSURL URLWithString:@"/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/focus_change_large.caf"];
            
            NSURL *focusSmallURL = [NSURL URLWithString:@"/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/focus_change_small.caf"];
            
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
    
    }
    
    else {
    
        %orig;
    
    }
    
}

%end


%ctor {

    preferences = [[HBPreferences alloc] initWithIdentifier:@"com.twickd.ethan-whited.musicqueuebegone"];
    [preferences registerBool:&enabled default:YES forKey:@"enabled"];
    [preferences registerInteger:&feedbackStyle default:0 forKey:@"feedbackStyle"];
    [preferences registerInteger:&ringStyle default:0 forKey:@"ringStyle"];
    
        %init(MusicQueueBeGone = objc_getClass("MusicApplication.ContextActionsHUDViewController"));

};
