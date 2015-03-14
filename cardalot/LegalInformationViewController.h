//
//  LegalInformationViewController.h
//  cardalot
//
//  Created by Ross McIlwaine on 3/14/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MMDrawerController;

@interface LegalInformationViewController : UIViewController <UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) MMDrawerController *drawerController;

@property (nonatomic, strong) UITableViewCell *attributionCell;
@property (nonatomic, strong) UITableViewCell *privacyPolicyCell;
@property (nonatomic, strong) UITableViewCell *termsOfServiceCell;

@end
