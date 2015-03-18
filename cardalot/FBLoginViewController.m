//
//  FBLoginViewController.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/16/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "FBLoginViewController.h"
#import "DeckCollectionViewController.h"
#import "MenuDrawerViewController.h"
#import "Settings.h"
#import "ErrorHandler.h"

BOOL viewDidAppear;
BOOL viewIsVisible;

@interface FBLoginViewController () <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation FBLoginViewController


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView {
   if (viewIsVisible) {
////        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
////        DeckCollectionViewController *deckVC = [storyboard instantiateViewControllerWithIdentifier:@"deckVC"];
       [self performSegueWithIdentifier:@"loginsegue" sender:loginView];
////        MenuDrawerViewController *settingsVC = [[MenuDrawerViewController alloc] init];
////
////        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:deckVC];
////        MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:navVC leftDrawerViewController:settingsVC];
////        
////        deckVC.drawerController = drawerController;
////
////        [self presentViewController:drawerController animated:YES completion:nil];
////
////        // Disable/Enable Drawer Gestures
////        drawerController.openDrawerGestureModeMask = MMOpenDrawerGestureModeAll;
////        drawerController.closeDrawerGestureModeMask = MMCloseDrawerGestureModeAll;
//
//    }
//}
   }
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.imageView =
    self.view.backgroundColor = [UIColor whiteColor];
//    self.drawerController = [[MMDrawerController alloc] init];
    self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];
    self.loginView.delegate = self;

    // [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(fbLoginSuccess) name:@"notifLogin" object:nil];
    // [self loginViewShowingLoggedInUser:self.loginView];
    //    FBLoginView *loginView = [[FBLoginView alloc] init];
    //    loginView.center = CGPointMake(self.view.center.x, self.view.center.y + 100);
    //    [self.view addSubview:loginView];
    // Do any additional setup after loading the view from its nib.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];

    Settings *settings = [Settings defaultSettings];
    if (viewDidAppear) {
        viewIsVisible = YES;

        // reset
        settings.shouldSkipLogin = NO;
    } else {
        [FBSession openActiveSessionWithAllowLoginUI:NO];
        FBSession *session = [FBSession activeSession];
        if (settings.shouldSkipLogin || session.isOpen) {
           // [self performSegueWithIdentifier:@"loginsegue" sender:self.loginView];
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            DeckCollectionViewController *deckVC = [storyboard instantiateViewControllerWithIdentifier:@"deckVC"];
            //[self performSegueWithIdentifier:@"loginsegue" sender:loginView];
            MenuDrawerViewController *settingsVC = [[MenuDrawerViewController alloc] init];

             UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:deckVC];
            MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:navVC leftDrawerViewController:settingsVC];

            deckVC.drawerController = drawerController;

            [self presentViewController:drawerController animated:YES completion:nil];
        } else {
            viewIsVisible = YES;
        }
        viewDidAppear = YES;
    }
}

- (void)viewWillDisappear:(BOOL)animated
{
    [super viewWillDisappear:animated];

    [Settings defaultSettings].shouldSkipLogin = YES;
    viewIsVisible = NO;
}

#pragma mark - FBLoginViewDelegate

- (void)loginView:(FBLoginView *)loginView
      handleError:(NSError *)error {
    HandleError(error);
}


//- (void)loginViewFetchedUserInfo:(FBLoginView *)loginView user:(id<FBGraphUser>)user
//{
//    NSLog(@"%@", user);
////    profileViewController.userString    = [user name];
////    profileViewController.emailString   = [user objectForKey:@"email"];
////    profileViewController.profileID     = user.id;
//    //self.profilePicture.profileID = user.id;
//    //self.lblUsername.text = user.name;
//   // self.lblEmail.text = [user objectForKey:@"email"];
//}


- (void)loginViewShowingLoggedOutUser:(FBLoginView *)loginView
{
    NSLog(@"You are logged out! :( ");
}


/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    DeckCollectionViewController *deckVC = (DeckCollectionViewController *)[segue destinationViewController];
    deckVC.drawerController = self.drawerController;
}

@end
