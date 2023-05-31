#include "MQBGPreferences.h"
#import <AudioToolbox/AudioServices.h>
#import <Cephei/HBPreferences.h>

#define bundlePath ([[NSFileManager defaultManager] fileExistsAtPath:@"/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/"] ? @"/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/" : @"/var/jb/Library/PreferenceBundles/musicqueuebegoneprefs.bundle/")

UIBarButtonItem *respringButtonItem;
UIBarButtonItem *changelogButtonItem;
UIBarButtonItem *twitterButtonItem;
UIBarButtonItem *paypalButtonItem;
UIViewController *popController;

@interface UIColor (Private)
+ (id)tableCellGroupedBackgroundColor;
@end

@implementation MQBGPreferencesListController
@synthesize killButton;
@synthesize versionArray;

- (NSArray *)specifiers {
    if (!_specifiers) {
        _specifiers = [self loadSpecifiersFromPlistName:@"Root" target:self];
    }

    return _specifiers;
}

- (instancetype)init {

    self = [super init];

    if (self) {
        
        MQBGAppearanceSettings *appearanceSettings = [[MQBGAppearanceSettings alloc] init];
        self.hb_appearanceSettings = appearanceSettings;
        UIButton *respringButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        respringButton.frame = CGRectMake(0,0,30,30);
        respringButton.layer.cornerRadius = respringButton.frame.size.height / 2;
        respringButton.layer.masksToBounds = YES;
        respringButton.backgroundColor = [UIColor tableCellGroupedBackgroundColor];
        [respringButton setImage:[[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@CHECKMARK.png", bundlePath]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [respringButton addTarget:self action:@selector(apply:) forControlEvents:UIControlEventTouchUpInside];
        respringButton.tintColor = [UIColor systemPinkColor];
        
        respringButtonItem = [[UIBarButtonItem alloc] initWithCustomView:respringButton];
        
        UIButton *changelogButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        changelogButton.frame = CGRectMake(0,0,30,30);
        changelogButton.layer.cornerRadius = changelogButton.frame.size.height / 2;
        changelogButton.layer.masksToBounds = YES;
        changelogButton.backgroundColor = [UIColor tableCellGroupedBackgroundColor];
        [changelogButton setImage:[[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@CHANGELOG.png", bundlePath]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [changelogButton addTarget:self action:@selector(showMenu:) forControlEvents:UIControlEventTouchUpInside];
        changelogButton.tintColor = [UIColor systemPinkColor];
        
        changelogButtonItem = [[UIBarButtonItem alloc] initWithCustomView:changelogButton];
        
        UIButton *twitterButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        twitterButton.frame = CGRectMake(0,0,30,30);
        twitterButton.layer.cornerRadius = twitterButton.frame.size.height / 2;
        twitterButton.layer.masksToBounds = YES;
        twitterButton.backgroundColor = [UIColor tableCellGroupedBackgroundColor];
        [twitterButton setImage:[[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@TWITTER.png", bundlePath]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [twitterButton addTarget:self action:@selector(twitter:) forControlEvents:UIControlEventTouchUpInside];
        twitterButton.tintColor = [UIColor systemPinkColor];
        
        twitterButtonItem = [[UIBarButtonItem alloc] initWithCustomView:twitterButton];
        
        UIButton *paypalButton =  [UIButton buttonWithType:UIButtonTypeCustom];
        paypalButton.frame = CGRectMake(0,0,30,30);
        paypalButton.layer.cornerRadius = paypalButton.frame.size.height / 2;
        paypalButton.layer.masksToBounds = YES;
        paypalButton.backgroundColor = [UIColor tableCellGroupedBackgroundColor];
        [paypalButton setImage:[[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@PAYPAL.png", bundlePath]] imageWithRenderingMode:UIImageRenderingModeAlwaysTemplate] forState:UIControlStateNormal];
        [paypalButton addTarget:self action:@selector(paypal:) forControlEvents:UIControlEventTouchUpInside];
        paypalButton.tintColor = [UIColor systemPinkColor];
        
        paypalButtonItem = [[UIBarButtonItem alloc] initWithCustomView:paypalButton];
        
        NSArray *rightButtons;
        rightButtons = @[respringButtonItem, changelogButtonItem, twitterButtonItem, paypalButtonItem];
        self.navigationItem.rightBarButtonItems = rightButtons;
        self.navigationItem.titleView = [UIView new];
        self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        self.titleLabel.font = [UIFont boldSystemFontOfSize:18];
        self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
        self.titleLabel.text = @"";
        self.titleLabel.textColor = [UIColor systemPinkColor];
        self.titleLabel.textAlignment = NSTextAlignmentCenter;
        [self.navigationItem.titleView addSubview:self.titleLabel];

        self.iconView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 10, 10)];
        self.iconView.contentMode = UIViewContentModeScaleAspectFit;
        self.iconView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@headericon.png", bundlePath]];
        self.iconView.translatesAutoresizingMaskIntoConstraints = NO;
        self.iconView.alpha = 0.0;
        [self.navigationItem.titleView addSubview:self.iconView];

        [NSLayoutConstraint activateConstraints:@[
            [self.titleLabel.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
            [self.titleLabel.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
            [self.titleLabel.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
            [self.titleLabel.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
            [self.iconView.topAnchor constraintEqualToAnchor:self.navigationItem.titleView.topAnchor],
            [self.iconView.leadingAnchor constraintEqualToAnchor:self.navigationItem.titleView.leadingAnchor],
            [self.iconView.trailingAnchor constraintEqualToAnchor:self.navigationItem.titleView.trailingAnchor],
            [self.iconView.bottomAnchor constraintEqualToAnchor:self.navigationItem.titleView.bottomAnchor],
        ]];

    }

    return self;

}

- (UIModalPresentationStyle)adaptivePresentationStyleForPresentationController:(UIPresentationController *)controller {

    return UIModalPresentationNone;
}

- (void)viewWillAppear:(BOOL)animated {

    [super viewWillAppear:animated];

    CGRect frame = self.table.bounds;
    frame.origin.y = -frame.size.height;
    
    self.view.tintColor = [UIColor systemPinkColor];
    [[UIApplication sharedApplication] keyWindow].tintColor = [UIColor systemPinkColor];

    self.navigationController.navigationController.navigationBar.barTintColor = [UIColor labelColor];
    [self.navigationController.navigationController.navigationBar setShadowImage: [UIImage new]];
    self.navigationController.navigationController.navigationBar.tintColor = [UIColor labelColor];
    self.navigationController.navigationController.navigationBar.translucent = NO;

}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    tableView.tableHeaderView = self.headerView;
    return [super tableView:tableView cellForRowAtIndexPath:indexPath];
}

- (void)viewDidLoad {

    [super viewDidLoad];
    
    self.view.tintColor = [UIColor systemPinkColor];
    [[UIApplication sharedApplication] keyWindow].tintColor = [UIColor systemPinkColor];

    self.headerView = [[UIView alloc] initWithFrame:CGRectMake(0,0,self.table.bounds.size.width,300)];
    
    self.artworkView = [[UIImageView alloc] initWithFrame:CGRectMake(self.headerView.frame.origin.x, self.headerView.frame.origin.y, self.headerView.frame.size.width, self.headerView.frame.size.height)];
    self.artworkView.contentMode = UIViewContentModeScaleAspectFit;
    self.artworkView.image = [UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@banner.png", bundlePath]];
    self.artworkView.layer.masksToBounds = YES;
    
    [self.headerView insertSubview:self.artworkView atIndex:0];
    
    self.artworkView.translatesAutoresizingMaskIntoConstraints = false;
    [NSLayoutConstraint activateConstraints:@[
        [self.artworkView.topAnchor constraintEqualToAnchor:self.headerView.topAnchor],
        [self.artworkView.leadingAnchor constraintEqualToAnchor:self.headerView.leadingAnchor],
        [self.artworkView.trailingAnchor constraintEqualToAnchor:self.headerView.trailingAnchor],
        [self.artworkView.bottomAnchor constraintEqualToAnchor:self.headerView.bottomAnchor],
    ]];
    _table.tableHeaderView = self.headerView;
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView {
    
    CGFloat offsetY = scrollView.contentOffset.y;

    if (offsetY > 200) {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 1.0;
            self.titleLabel.alpha = 0.0;
        }];
    } else {
        [UIView animateWithDuration:0.2 animations:^{
            self.iconView.alpha = 0.0;
            self.titleLabel.alpha = 1.0;
        }];
    }

    if (offsetY > 0) offsetY = 0;
    self.artworkView.frame = CGRectMake(self.headerView.frame.origin.x, self.headerView.frame.origin.y, self.headerView.frame.size.width, 200 - offsetY);
}

- (void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];

    [self.navigationController.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor blackColor]}];
}

- (void)apply:(UIButton *)sender {
    
    popController = [[UIViewController alloc] init];
    popController.modalPresentationStyle = UIModalPresentationPopover;
    popController.preferredContentSize = CGSizeMake(200,130);
    UILabel *respringLabel = [[UILabel alloc] init];
    respringLabel.frame = CGRectMake(20, 20, 160, 60);
    respringLabel.numberOfLines = 2;
    respringLabel.textAlignment = NSTextAlignmentCenter;
    respringLabel.adjustsFontSizeToFitWidth = YES;
    respringLabel.font = [UIFont boldSystemFontOfSize:20];
    respringLabel.textColor = [UIColor systemPinkColor];
    respringLabel.text = @"Are you sure you want to kill Music.app?";
    [popController.view addSubview:respringLabel];
    
    UIButton *yesButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [yesButton addTarget:self
                  action:@selector(handleYesGesture:)
     forControlEvents:UIControlEventTouchUpInside];
    [yesButton setTitle:@"Yes" forState:UIControlStateNormal];
    yesButton.titleLabel.font = respringLabel.font;
    [yesButton setTitleColor:[UIColor systemPinkColor] forState:UIControlStateNormal];
    yesButton.frame = CGRectMake(100, 100, 100, 30);
    [popController.view addSubview:yesButton];
    
    UIButton *noButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [noButton addTarget:self
                  action:@selector(handleNoGesture:)
     forControlEvents:UIControlEventTouchUpInside];
    [noButton setTitle:@"No" forState:UIControlStateNormal];
    noButton.titleLabel.font = respringLabel.font;
    [noButton setTitleColor:[UIColor systemPinkColor] forState:UIControlStateNormal];
    noButton.frame = CGRectMake(0, 100, 100, 30);
    [popController.view addSubview:noButton];
     
    UIPopoverPresentationController *popover = popController.popoverPresentationController;
    popover.delegate = self;
    popover.permittedArrowDirections = UIPopoverArrowDirectionUp;
    popover.barButtonItem = respringButtonItem;
    popover.backgroundColor = [UIColor tableCellGroupedBackgroundColor];
    
    [self presentViewController:popController animated:YES completion:nil];
    
    AudioServicesPlaySystemSound(1519);

}

- (void)showMenu:(id)sender {
    
    AudioServicesPlaySystemSound(1519);

    self.changelogController = [[OBWelcomeController alloc] initWithTitle:@"MusicQueueBeGone" detailText:@"1.7" icon:[UIImage imageWithContentsOfFile:[NSString stringWithFormat:@"%@changelogControllerIcon.png", bundlePath]]];

    [self.changelogController addBulletedListItemWithTitle:@"Support" description:@"Support for iOS 16.5." image:[UIImage systemImageNamed:@"1.circle.fill"]];

    _UIBackdropViewSettings *settings = [_UIBackdropViewSettings settingsForStyle:2];

    _UIBackdropView *backdropView = [[_UIBackdropView alloc] initWithSettings:settings];
    backdropView.layer.masksToBounds = YES;
    backdropView.clipsToBounds = YES;
    backdropView.frame = self.changelogController.viewIfLoaded.frame;
    [self.changelogController.viewIfLoaded insertSubview:backdropView atIndex:0];
    
    backdropView.translatesAutoresizingMaskIntoConstraints = false;
    [backdropView.bottomAnchor constraintEqualToAnchor:self.changelogController.viewIfLoaded.bottomAnchor constant:0].active = YES;
    [backdropView.leftAnchor constraintEqualToAnchor:self.changelogController.viewIfLoaded.leftAnchor constant:0].active = YES;
    [backdropView.rightAnchor constraintEqualToAnchor:self.changelogController.viewIfLoaded.rightAnchor constant:0].active = YES;
    [backdropView.topAnchor constraintEqualToAnchor:self.changelogController.viewIfLoaded.topAnchor constant:0].active = YES;

    self.changelogController.viewIfLoaded.backgroundColor = [UIColor clearColor];
    for (OBBulletedListItem *item in self.changelogController.bulletedList.items) {
        item.imageView.tintColor = [UIColor systemPinkColor];
    }
    self.changelogController.modalPresentationStyle = UIModalPresentationPageSheet;
    self.changelogController.modalInPresentation = NO;
    [self presentViewController:self.changelogController animated:YES completion:nil];
}
- (void)dismissVC {
    [self.changelogController dismissViewControllerAnimated:YES completion:nil];
}

- (void)twitter:(id)sender {
    AudioServicesPlaySystemSound(1519);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://twitter.com/EthanWhited"] options:@{} completionHandler:nil];
}

- (void)paypal:(id)sender {
    AudioServicesPlaySystemSound(1519);
    
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"https://paypal.me/nahtedetihw"] options:@{} completionHandler:nil];
}

- (void)handleYesGesture:(UIButton *)sender {
    AudioServicesPlaySystemSound(1519);

    [popController dismissViewControllerAnimated:YES completion:nil];

    pid_t pid;
    const char* args[] = {"killall", "Music", NULL};
    if ([[NSFileManager defaultManager] fileExistsAtPath:@"/usr/bin/killall"]) {
        posix_spawn(&pid, "usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
    } else {
        posix_spawn(&pid, "/var/jb/usr/bin/killall", NULL, NULL, (char* const*)args, NULL);
    }
    
    [self launchMusic];
}

- (void)handleNoGesture:(UIButton *)sender {
    AudioServicesPlaySystemSound(1519);
    [popController dismissViewControllerAnimated:YES completion:nil];
}

- (void)launchMusic {
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, 0.4 * NSEC_PER_SEC), dispatch_get_main_queue(), ^{
            [[UIApplication sharedApplication] launchApplicationWithIdentifier:@"com.apple.Music" suspended:0];
        });
}
@end



@implementation MQBGAppearanceSettings: HBAppearanceSettings
- (UIColor *)tintColor {
    return [UIColor systemPinkColor];
}

- (UIColor *)tableViewCellSeparatorColor {
    return [UIColor clearColor];
}
@end
