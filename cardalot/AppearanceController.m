//
//  AppearanceController.m
//
//  Created by Jason Noah Choi on 2/17/15.
//  Copyright (c) 2015 DevMountain. All rights reserved.
//

#import "AppearanceController.h"
#import "DeckCollectionViewController.h"
#import "UIColor+Colors.h"

@implementation AppearanceController

+ (void)setupDefaultAppearance {
    [[UINavigationBar appearance] setBarTintColor:[UIColor whiteColor]];
    [[UINavigationBar appearance] setTitleTextAttributes:@{NSForegroundColorAttributeName:[UIColor customBlueColor]}];

  //  [[UIBarButtonItem appearance] setTintColor:[UIColor colorWithHue:204.0/360 saturation:.78 brightness:.66 alpha:1.0]];

    //[[UINavigationBar appearanceWhenContainedIn:[DeckCollectionViewController class], nil] setBarTintColor:[UIColor colorWithHue:204.0/360 saturation:.78 brightness:.66 alpha:1.0]];

//    [[UIToolbar appearance] setBarTintColor:[UIColor colorWithHue:282.0/360 saturation:.38 brightness:.84 alpha:1.0]];
//
//    [[UISegmentedControl appearance] setTintColor:[UIColor colorWithHue:3.0/360 saturation:.62 brightness:1.0 alpha:1.0]];
//    [[UISegmentedControl appearance] setTitle:@"Color" forSegmentAtIndex:0];
//    [[UISegmentedControl appearance] setTitle:@"White" forSegmentAtIndex:1];
//    [[UISegmentedControl appearance] setTintAdjustmentMode:UIViewTintAdjustmentModeAutomatic];

   
    
    
}

@end
