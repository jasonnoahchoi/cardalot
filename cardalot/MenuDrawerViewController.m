//
//  MenuDrawerViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "MenuDrawerViewController.h"
#import "PurchasedDataController.h"
#import "StorePurchaseController.h"
#import "IAPViewController.h"
#import "RemindersViewController.h"
#import <MMDrawerController/UIViewController+MMDrawerController.h>
#import <FacebookSDK/FacebookSDK.h>

static NSString * const kGoPro = @"goPro";

@interface MenuDrawerViewController () <UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) LogoMenuCell *logoMenuCell;
@property (nonatomic, strong) SearchCell *searchCell;

@end

@implementation MenuDrawerViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    self.title = @"Cardalot";

    self.tableView = [[UITableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];

    [self.view endEditing:YES];
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeOnDrag;
    self.tableView.keyboardDismissMode = UIScrollViewKeyboardDismissModeInteractive;

    self.tableView.allowsSelection = YES;

    self.tableView.dataSource = self;
    self.tableView.delegate = self;

    self.tableView.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
    
# pragma profile pic cell
    [self.view addSubview:self.tableView];
}

- (UIStatusBarStyle)preferredStatusBarStyle {
    return UIStatusBarStyleLightContent;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 8;
}

- (void)inAppPurchase {
    [[StorePurchaseController sharedInstance] requestProducts];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsRequested:) name:kInAppPurchaseFetchedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsPurchased:) name:kInAppPurchaseCompletedNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(productsRestored:) name:kInAppPurchaseRestoredNotification object:nil];
}

- (void)productsRequested:(NSNotification *)notification {

}

- (void)productsPurchased:(NSNotification *)notification {
}

- (void)productsRestored:(NSNotification *)notification {
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        self.logoMenuCell = [[LogoMenuCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell2"];
        self.logoMenuCell.selectionStyle = UITableViewCellSelectionStyleNone;
        return self.logoMenuCell;
    } else if (indexPath.row == 7) {
#pragma Mark - sets Facebook User profile and name
        self.profilePictureCell = [UITableViewCell new];
        self.profilePictureCell.selectionStyle = UITableViewCellSelectionStyleNone;
        self.profilePictureCell.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
        [FBRequestConnection startForMeWithCompletionHandler:^(FBRequestConnection *connection, id result, NSError *error) {
            self.profilePictureCell.textLabel.text = [NSString stringWithFormat:@"%@ \n%@", result[@"first_name"], result[@"last_name"]];
            NSString *url = [NSString stringWithFormat:@"http://graph.facebook.com/%@/picture?type=large", result[@"id"]];
            NSData *pictureData = [NSData dataWithContentsOfURL:[NSURL URLWithString:url]];
            UIImage *profilePicture = [UIImage imageWithData:pictureData];
            self.profilePictureCell.imageView.image = profilePicture;
            self.profilePictureCell.contentMode = UIViewContentModeScaleAspectFit;
            self.profilePictureCell.textLabel.font = [UIFont systemFontOfSize:14.0];
            self.profilePictureCell.textLabel.textColor = [UIColor whiteColor];
            self.profilePictureCell.textLabel.numberOfLines = 0;
        }];
        return self.profilePictureCell;
    } else {  // for string with format add the itentifier for account type
        BOOL goPro = [[NSUserDefaults standardUserDefaults] boolForKey:kGoPro];
        if (goPro) {
            NSArray *menuListArray = @[@"Account Type: PRO", @"Progress", @"Rate App", @"Reminders", @"Refer Friends", @"Settings"];
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
            NSAttributedString *attText = [[NSAttributedString alloc]initWithString:menuListArray[indexPath.row - 1] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0]}];
            cell.textLabel.attributedText = attText;

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        } else {
            NSArray *menuListArray = @[@"Account Type: FREE", @"Progress", @"Rate App", @"Reminders", @"Refer Friends", @"Settings"];
            UITableViewCell *cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"Cell"];
            cell.backgroundColor = [UIColor colorWithRed:0.25 green:0.25 blue:0.25 alpha:1];
            NSAttributedString *attText = [[NSAttributedString alloc]initWithString:menuListArray[indexPath.row - 1] attributes:@{NSForegroundColorAttributeName:[UIColor whiteColor], NSFontAttributeName:[UIFont systemFontOfSize:16.0]}];
            cell.textLabel.attributedText = attText;

            cell.selectionStyle = UITableViewCellSelectionStyleNone;
            return cell;
        }
    }
}

#pragma mark - sets the tableview links to ViewControllers
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {

    UINavigationController *navigationController = (UINavigationController *)self.mm_drawerController.centerViewController;
    
    if (indexPath.row == 0) {
        DeckCollectionViewController *deckCollectionVC = [DeckCollectionViewController new];
        deckCollectionVC.drawerController = self.mm_drawerController;
        UINavigationController *deckHomeNavController = [[UINavigationController alloc] initWithRootViewController:deckCollectionVC];
        [self.mm_drawerController setCenterViewController:deckHomeNavController];
        [navigationController popToRootViewControllerAnimated:YES];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    } else if (indexPath.row == 1) {
        IAPViewController *vc = [[IAPViewController alloc] init];
        vc.drawerController = self.mm_drawerController;
        UINavigationController *iapNavVC = [[UINavigationController alloc] initWithRootViewController:vc];
        [self.mm_drawerController setCenterViewController:iapNavVC];
        [navigationController popToRootViewControllerAnimated:YES];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];

    } else if (indexPath.row == 2) {
        StatsViewController *statsVC = [StatsViewController new];
        statsVC.drawerController = self.mm_drawerController;
        UINavigationController *statsNavController =[[UINavigationController alloc] initWithRootViewController:statsVC];
        [self.mm_drawerController setCenterViewController:statsNavController];
        [navigationController popToRootViewControllerAnimated:YES];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    } else if (indexPath.row == 3) {
        NSString *appID = @"979032668";
        NSURL *appStoreURL = [NSURL URLWithString:[NSString stringWithFormat:@"itms-apps://itunes.apple.com/app/id%@", appID]];
        [[UIApplication sharedApplication] openURL:appStoreURL];
        NSLog(@"NSSTRING: %@, NSURL: %@", appID, appStoreURL);
    } else if (indexPath.row == 4) {
        
        RemindersViewController *reminderVC = [RemindersViewController new];
        UINavigationController *reminderNavController = [[UINavigationController alloc] initWithRootViewController:reminderVC];
        [self presentViewController:reminderNavController animated:YES completion:nil];

    } else if (indexPath.row == 5) {
        ReferralViewController *referralVC = [ReferralViewController new];
        referralVC.drawerController = self.mm_drawerController;
        UINavigationController *referralNavController = [[UINavigationController alloc] initWithRootViewController:referralVC];
        [self.mm_drawerController setCenterViewController:referralNavController];
        [navigationController popToRootViewControllerAnimated:YES];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    } else if (indexPath.row == 6) {
        SettingsMenuViewController *settingsVC = [SettingsMenuViewController new];
        settingsVC.drawerController = self.mm_drawerController;
        UINavigationController *settingsNavController = [[UINavigationController alloc] initWithRootViewController:settingsVC];
        [self.mm_drawerController setCenterViewController:settingsNavController];
        [navigationController popToRootViewControllerAnimated:YES];
        [self.mm_drawerController closeDrawerAnimated:YES completion:nil];
    }
}


#pragma mark - custom menu cell height
-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    if (indexPath.row == 0) {
        return 135;
    } else {
        return 54;
    }
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
