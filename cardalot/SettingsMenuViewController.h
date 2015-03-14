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

@end
