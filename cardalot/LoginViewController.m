//
//  LoginViewController.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/15/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "LoginViewController.h"
#import "DeckCollectionViewController.h"
#import "MenuDrawerViewController.h"
#import "Settings.h"
#import "ErrorHandler.h"

BOOL viewDidAppear;
BOOL viewIsVisible;

@interface LoginViewController ()

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation LoginViewController

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // Facebook SDK * pro-tip *
        // We wire up the FBLoginView using the interface builder
        // but we could have also explicitly wired its delegate here.
        self.loginView.delegate = self;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    //self.imageView =
    self.view.backgroundColor = [UIColor whiteColor];
    self.drawerController = [[MMDrawerController alloc] init];
    self.loginView.readPermissions = @[@"public_profile", @"email", @"user_friends"];

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
            UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
            DeckCollectionViewController *deckCollectionVC = [storyboard instantiateViewControllerWithIdentifier:@"deckVC"];
         //   UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:deckCollectionVC];


            MenuDrawerViewController *settingsVC = [[MenuDrawerViewController alloc] init];

            MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:deckCollectionVC leftDrawerViewController:settingsVC];

            deckCollectionVC.drawerController = drawerController;
            [self.navigationController pushViewController:deckCollectionVC animated:YES];
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

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - FBLoginViewDelegate

- (void)loginView:(FBLoginView *)loginView
      handleError:(NSError *)error {
    HandleError(error);
}

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView
{
    if (viewIsVisible) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        DeckCollectionViewController *deckCollectionVC = [storyboard instantiateViewControllerWithIdentifier:@"deckVC"];
//        UINavigationController *navVC = [[UINavigationController alloc] initWithRootViewController:deckCollectionVC];


        MenuDrawerViewController *settingsVC = [[MenuDrawerViewController alloc] init];

        MMDrawerController *drawerController = [[MMDrawerController alloc] initWithCenterViewController:deckCollectionVC leftDrawerViewController:settingsVC];

        deckCollectionVC.drawerController = drawerController;
        [self.navigationController pushViewController:deckCollectionVC animated:YES];

       // [self performSegueWithIdentifier:@"showMain" sender:loginView];
    }
}


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

@end
