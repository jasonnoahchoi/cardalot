//
//  AppDelegate.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "AppDelegate.h"
#import "DeckCollectionViewController.h"
#import "StudyViewController.h"
#import <MMDrawerController.h>
#import "AppearanceController.h"
#import "MenuDrawerViewController.h"
#import "RemindersViewController.h"

@interface AppDelegate ()

@end

static NSString * const launchCountKey = @"launchCount";

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    // Override point for customization after application launch.
    [AppearanceController setupDefaultAppearance];

    DeckCollectionViewController *deckCollectionVC = [[DeckCollectionViewController alloc] init];

    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:deckCollectionVC];
    
    MenuDrawerViewController *settingsVC = [[MenuDrawerViewController alloc] init];
    
    MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:navVC leftDrawerViewController:settingsVC];
    
    deckCollectionVC.drawerController = drawerController;
    
    self.window.rootViewController = drawerController;
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;
    
    [self trackLaunches];
    
    return YES;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Launch Tracker
- (void)trackLaunches {
    NSInteger launchCount = [[NSUserDefaults standardUserDefaults] integerForKey:launchCountKey];
    
    if (launchCount) {
        launchCount++;
    } else {
        launchCount = 1;
    }
    
    NSLog(@"%ld", (long) launchCount);
    
    [[NSUserDefaults standardUserDefaults] setInteger:launchCount forKey:launchCountKey];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (launchCount == 3) {
        UIAlertController *rateAppAlertController = [UIAlertController alertControllerWithTitle:@"Rate the app" message:@"We hope you love the app as much as we do. Please consider rating the app on the App Store." preferredStyle:UIAlertControllerStyleAlert];
        [rateAppAlertController addAction:[UIAlertAction actionWithTitle:@"Cancel" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"Cancel");
            RateAppViewController *rateAppVC = [[RateAppViewController alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rateAppVC];
            [self.window.rootViewController presentViewController:navController animated:YES completion:nil];
        }]];
        [rateAppAlertController addAction:[UIAlertAction actionWithTitle:@"Rate app" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"rate app");
        }]];
        [self.window.rootViewController presentViewController:rateAppAlertController animated:YES completion:nil];
    }
}

@end
