//
//  IAPViewController.h
//  Cardalot
//
//  Created by Jason Noah Choi on 3/30/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//


#import <UIKit/UIKit.h>
@class MMDrawerController;

typedef enum {
    kFirstCell,
    kSecondCell,
} kCellLayout;

@interface IAPViewController : UIViewController

@property (nonatomic, strong) MMDrawerController *drawerController;

@end
