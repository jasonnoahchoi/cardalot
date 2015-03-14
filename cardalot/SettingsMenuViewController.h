//
//  SettingsMenuViewController.h
//  cardalot
//
//  Created by Ross McIlwaine on 3/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMDrawerController;

@interface SettingsMenuViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MMDrawerController *drawerController;

@property (nonatomic, strong) UITableViewCell *advancedSettingsCell;
@property (nonatomic, strong) UITableViewCell *supportCell;
@property (nonatomic, strong) UITableViewCell *legalCell;

@property (nonatomic, strong) UITableViewCell *reminderCell;
@property (nonatomic, strong) UITableViewCell *howToUseCell;
@property (nonatomic, strong) UITableViewCell *versionCell;

@property (nonatomic, strong) UILabel *versionLabel;

@end
