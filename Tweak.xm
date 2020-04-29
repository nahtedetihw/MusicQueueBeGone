#import "Tweak.h"

BOOL enabled;
HBPreferences *preferences;
NSInteger feedbackStyle;
NSInteger notifeedbackStyle;
NSInteger ringStyle;

static void feedbackcall() {
UIImpactFeedbackGenerator * feedback = [[UIImpactFeedbackGenerator alloc] initWithStyle:(int)feedbackStyle];
[feedback prepare];
[feedback impactOccurred];
}

%hook _UINotificationFeedbackGeneratorConfiguration

-(BOOL)defaultEnabled {

    if (enabled) {
    
    return NO;
    
    }
    
    return %orig;
    
}

%end

%hook _TtC5Music31ContextActionsHUDViewController

- (void)viewDidLoad {

    if (enabled) {
    
    //Do Nothing
    
    }
    
    else {
    
    %orig;
    
    }
        
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
    
            switch (ringStyle) {

                case 0:
                AudioServicesPlaySystemSound(1051);
                break;

                case 1:
                AudioServicesPlaySystemSound(1052);
                break;

                case 2:
                AudioServicesPlaySystemSound(1053);
                break;

                case 3:
                break;

                default:
                break;
    
    
            }
        
}

%end

//iOS 13 Support
%hook MusicQueueBeGone

- (void)viewDidLoad {

    if (enabled) {
    
    //Do Nothing
    
    }
    
    else {
    
    %orig;
    
    }
        
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
    
            switch (ringStyle) {

                case 0:
                AudioServicesPlaySystemSound(1051);
                break;

                case 1:
                AudioServicesPlaySystemSound(1052);
                break;

                case 2:
                AudioServicesPlaySystemSound(1053);
                break;
        
                case 3:
                break;

                default:
                break;
                
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
