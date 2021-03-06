//
//  AdvancedSettingsViewController.h
//  cardalot
//
//  Created by Ross McIlwaine on 3/15/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMDrawerController;

@interface AdvancedSettingsViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MMDrawerController *drawerController;

@property (nonatomic, strong) UITableViewCell *logoutCell;

@end
