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
#import "LoginViewController.h"
#import <Parse/Parse.h>
#import <Facebook-iOS-SDK/FacebookSDK/FacebookSDK.h>
//#import "FacebookSDK/FBUserSettingsViewController.h"
#import "Settings.h"
#import "ErrorHandler.h"
#import "FBLoginViewController.h"
#import "TutorialSlidesContainerViewController.h"

@interface AppDelegate ()

@property (nonatomic, strong) LoginViewController *loginVC;
@property (nonatomic, strong) IBOutlet UINavigationController *navVC;
@end

static NSString * const launchCountKey = @"launchCount";
static NSString * const remindLaterKey = @"remind";

@implementation AppDelegate

+ (void)initialize
{
    // Nib files require the type to have been loaded before they can do the wireup successfully.
    // http://stackoverflow.com/questions/1725881/unknown-class-myclass-in-interface-builder-file-error-at-runtime
    [FBLoginView class];
    [FBProfilePictureView class];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    
    NSInteger launchCount = [[NSUserDefaults standardUserDefaults] integerForKey:launchCountKey];
    
    // [Optional] Power your app with Local Datastore. For more info, go to
    // https://parse.com/docs/ios_guide#localdatastore/iOS
    [Parse enableLocalDatastore];

    // Initialize Parse.
    [Parse setApplicationId:@"2MdVwUsOQKtVnXhlFC5a2riMmtjJeIROo9wPixO5"
                  clientKey:@"wSQMqHfXbKBYCfAaBJGf1jEbtoqILNicv49Y6AHU"];

    // [Optional] Track statistics around application opens.
    [PFAnalytics trackAppOpenedWithLaunchOptions:launchOptions];

    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];

    // Override point for customization after application launch.
    [AppearanceController setupDefaultAppearance];

    DeckCollectionViewController *deckCollectionVC = [[DeckCollectionViewController alloc] init];
    UINavigationController *deckNavController = [[UINavigationController alloc] initWithRootViewController:deckCollectionVC];

    MenuDrawerViewController *settingsVC = [[MenuDrawerViewController alloc] init];
//    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
//    FBLoginViewController *fbLoginVC = [storyboard instantiateViewControllerWithIdentifier:@"fbloginvc"];

    TutorialSlidesContainerViewController *slidesVC = [[TutorialSlidesContainerViewController alloc] init];

//    UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:fbLoginVC];

    //self.drawerController = [[MMDrawerController alloc] initWithCenterViewController:navVC leftDrawerViewController:settingsVC];
    MMDrawerController *drawerController = [[MMDrawerController alloc] init];
    [drawerController setLeftDrawerViewController:settingsVC];
    if (FBSession.activeSession.state != FBSessionStateCreatedTokenLoaded) {
        [drawerController setCenterViewController:slidesVC];
        slidesVC.drawerController = drawerController;
      //  deckCollectionVC.drawerController = drawerController;
//        fbLoginVC.drawerController = drawerController;
        [[UIApplication sharedApplication] cancelAllLocalNotifications];
    } else {
        [self trackLaunches];
        [drawerController setCenterViewController:deckNavController];
        deckCollectionVC.drawerController = drawerController;
    }

    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];

    /// NOT SURE WHAT TO DO TO START SLIDE SHOW
    
//    if (launchCount == 1) {
//        self.window.rootViewController = slidesVC;
//    }
/////    self.window.rootViewController = drawerController;
    self.window.rootViewController = drawerController;
    
    [UIApplication sharedApplication].applicationIconBadgeNumber = 0;

    NSLog(@"%@", [UIApplication sharedApplication].scheduledLocalNotifications);
  //   Whenever a person opens the app, check for a cached session
    if (FBSession.activeSession.state == FBSessionStateCreatedTokenLoaded) {
        NSLog(@"Found a cached session");
        // If there's one, just open the session silently, without showing the user the login UI
        [FBSession openActiveSessionWithReadPermissions:nil
                                           allowLoginUI:YES
                                      completionHandler:^(FBSession *session, FBSessionState state, NSError *error) {
                                          if (state == FBSessionStateOpen || state == FBSessionStateOpenTokenExtended) {
                                              //Call your view controller after login
                                              //[self.loginVC loginViewShowingLoggedInUser:self.loginVC.loginView];
                                           //   [self changeRootViewController];
                                              NSLog(@"Logged in!");
                                              [self sessionStateChanged:session state:state error:error];

                                          }
                                          // Handler for session state changes
                                          // This method will be called EACH time the session state changes,
                                          // also for intermediate states and NOT just when the session open
                                                                                }];

        // If there's no cached session, we will show a login button
    } else {
        [self.loginVC loginView];
        NSLog(@"Not logged in");
        //[FBLoginView setTitle:@"Log in with Facebook" forState:UIControlStateNormal];
    }

    
    if (launchCount == 3) {
        UIAlertController *rateAppAlertController = [UIAlertController alertControllerWithTitle:@"Rate Cardalot" message:@"If you enjoy using Cardalot, would you mind taking a moment to rate it? It won't take more than a minute. Thanks for your support!" preferredStyle:UIAlertControllerStyleAlert];
        [rateAppAlertController addAction:[UIAlertAction actionWithTitle:@"Rate It Now" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"rate app");
            NSString *appID = @"979032668";
            NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appID]];
            [[UIApplication sharedApplication] openURL:appStoreURL];
        }]];
        [rateAppAlertController addAction:[UIAlertAction actionWithTitle:@"Not a Fan" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"Cancel");
            RateAppViewController *rateAppVC = [[RateAppViewController alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rateAppVC];
            [self.window.rootViewController presentViewController:navController animated:YES completion:nil];
        }]];
        [rateAppAlertController addAction:[UIAlertAction actionWithTitle:@"Remind Me Later" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
            [[NSUserDefaults standardUserDefaults] setBool:YES forKey:remindLaterKey];
        }]];
        [self.window.rootViewController presentViewController:rateAppAlertController animated:YES completion:nil];
    }
    
    BOOL remind = [[NSUserDefaults standardUserDefaults] boolForKey:remindLaterKey];
    if (launchCount == 8 && remind) {
        UIAlertController *rateAppAlertController = [UIAlertController alertControllerWithTitle:@"Rate Cardalot" message:@"If you enjoy using Cardalot, would you mind taking a moment to rate it? It won't take more than a minute. Thanks for your support!" preferredStyle:UIAlertControllerStyleAlert];
        [rateAppAlertController addAction:[UIAlertAction actionWithTitle:@"Rate It Now" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"rate app");
            NSString *appName = @"id979032668";
            NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/%@", appName]];
            [[UIApplication sharedApplication] openURL:appStoreURL];
        }]];
        [rateAppAlertController addAction:[UIAlertAction actionWithTitle:@"Not a Fan" style:UIAlertActionStyleDefault handler:^(UIAlertAction *action) {
            NSLog(@"Cancel");
            RateAppViewController *rateAppVC = [[RateAppViewController alloc] init];
            UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:rateAppVC];
            [self.window.rootViewController presentViewController:navController animated:YES completion:nil];
        }]];
        [rateAppAlertController addAction:[UIAlertAction actionWithTitle:@"No, thanks" style:UIAlertActionStyleCancel handler:^(UIAlertAction *action) {
        }]];
        [self.window.rootViewController presentViewController:rateAppAlertController animated:YES completion:nil];
    }

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
    // Logs 'install' and 'app activate' App Events
    [FBAppEvents activateApp];
    [FBAppCall handleDidBecomeActive];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

#pragma mark - Helper Methods

- (void)_handleOpenURLWithAccessToken:(FBAccessTokenData *)token {
    // Initialize a new blank session instance...
    FBSession *sessionFromToken = [[FBSession alloc] initWithAppID:nil
                                                       permissions:nil
                                                   defaultAudience:FBSessionDefaultAudienceNone
                                                   urlSchemeSuffix:nil
                                                tokenCacheStrategy:[FBSessionTokenCachingStrategy nullCacheInstance] ];
    [FBSession setActiveSession:sessionFromToken];
    // ... and open it from the supplied token.
    [sessionFromToken openFromAccessTokenData:token
                            completionHandler:^(FBSession *session, FBSessionState status, NSError *error) {
                                // Forward any errors to the FBLoginView delegate.
                                if (error) {
                                    HandleError(error);
                                }
                            }];
}
// This method will handle ALL the session state changes in the app
- (void)sessionStateChanged:(FBSession *)session state:(FBSessionState) state error:(NSError *)error {
    // If the session was opened successfully
    if (!error && state == FBSessionStateOpen) {
        NSLog(@"Session opened");
        // Show the user the logged-in UI
        return;
    }
    if (state == FBSessionStateClosed || state == FBSessionStateClosedLoginFailed){
        // If the session is closed
        NSLog(@"Session closed");
        // Show the user the logged-out UI
        [self userLoggedOut];
    }

    // Handle errors
    if (error){
        NSLog(@"Error");
        NSString *alertText;
        NSString *alertTitle;
        // If the error requires people using an app to make an action outside of the app in order to recover
        if ([FBErrorUtility shouldNotifyUserForError:error] == YES) {
            alertTitle = @"Something went wrong";
            alertText = [FBErrorUtility userMessageForError:error];
            [self showMessage:alertText withTitle:alertTitle];
        } else {

            // If the user cancelled login, do nothing
            if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryUserCancelled) {
                NSLog(@"User cancelled login");

                // Handle session closures that happen outside of the app
            } else if ([FBErrorUtility errorCategoryForError:error] == FBErrorCategoryAuthenticationReopenSession){
                alertTitle = @"Session Error";
                alertText = @"Your current session is no longer valid. Please log in again.";
                [self showMessage:alertText withTitle:alertTitle];

                // For simplicity, here we just show a generic message for all other errors
                // You can learn how to handle other errors using our guide: https://developers.facebook.com/docs/ios/errors
            } else {
                //Get more error information from the error
                NSDictionary *errorInformation = [[[error.userInfo objectForKey:@"com.facebook.sdk:ParsedJSONResponseKey"] objectForKey:@"body"] objectForKey:@"error"];

                // Show the user an error message
                alertTitle = @"Something went wrong";
                alertText = [NSString stringWithFormat:@"Please retry. \n\n If the problem persists contact us and mention this error code: %@", [errorInformation objectForKey:@"message"]];
                [self showMessage:alertText withTitle:alertTitle];
            }
        }
        // Clear this token
        [FBSession.activeSession closeAndClearTokenInformation];
        // Show the user the logged-out UI
        [self userLoggedOut];
    }
}

 //Show the user the logged-out UI
- (void)userLoggedOut
{
    // Set the button title as "Log in with Facebook"
   // UIButton *loginButton = (UIButton *)[self.loginVC loginView];
  //  [loginButton setTitle:@"Log in with Facebook" forState:UIControlStateNormal];

    // Confirm logout message
    [self showMessage:@"You're now logged out" withTitle:@""];
}


// Show an alert message
- (void)showMessage:(NSString *)text withTitle:(NSString *)title
{
    [[[UIAlertView alloc] initWithTitle:title
                                message:text
                               delegate:self
                      cancelButtonTitle:@"OK!"
                      otherButtonTitles:nil] show];
}


- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    // Facebook SDK * login flow *
    // Attempt to handle URLs to complete any auth (e.g., SSO) flow.
    return [FBAppCall handleOpenURL:url sourceApplication:sourceApplication fallbackHandler:^(FBAppCall *call) {
        // Since Scrumptious supports Single Sign On from the Facebook App (such as bookmarks),
        // we supply a fallback handler to parse any inbound URLs (e.g., deep links)
        // which can contain an access token.
        if (call.accessTokenData) {
            if ([FBSession activeSession].isOpen) {
                //[self.window.rootViewController.navigationController pushViewController:self.navVC animated:YES];
                NSLog(@"INFO: Ignoring new access token because current session is open.");
            }
            else {
                [self _handleOpenURLWithAccessToken:call.accessTokenData];
            }
        }
    }];
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
}

@end
