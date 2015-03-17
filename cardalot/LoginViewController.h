//
//  LoginViewController.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/15/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Facebook-iOS-SDK/FacebookSDK/FacebookSDK.h>
#import <MMDrawerController.h>

@interface LoginViewController : UIViewController <FBLoginViewDelegate>

@property (weak, nonatomic) IBOutlet FBLoginView *loginView;
@property (nonatomic, strong) MMDrawerController *drawerController;

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView;

@end
