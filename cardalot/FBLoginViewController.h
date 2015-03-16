//
//  FBLoginViewController.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/16/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Facebook-iOS-SDK/FacebookSDK/FacebookSDK.h>
#import <MMDrawerController.h>

@interface FBLoginViewController : UIViewController

@property (nonatomic, strong) MMDrawerController *drawerController;
@property (strong, nonatomic) IBOutlet FBLoginView *loginView;

- (void)loginViewShowingLoggedInUser:(FBLoginView *)loginView;

@end
