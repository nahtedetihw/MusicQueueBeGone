#import <AudioToolbox/AudioServices.h>

%hook MusicQueueBeGone

- (void)viewDidLoad

{

    AudioServicesPlaySystemSound(1519);
    
}

%end

%ctor {

    %init(MusicQueueBeGone = objc_getClass("Music.ContextActionsHUDViewController"));
    
};
