
//
//  TutorialSlidesContainerViewController.m
//  cardalot
//
//  Created by sombra on 2015-03-19.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "TutorialSlidesContainerViewController.h"
#import "UIColor+Colors.h"
#import "SlideFiveViewController.h"
#import "SlideFourViewController.h"
#import "SlideThreeViewController.h"
#import "SlideTwoViewController.h"
#import "SlideOneViewController.h"
#import "FBLoginViewController.h"
#import <UIViewController+MMDrawerController.h>

@interface TutorialSlidesContainerViewController () <UIPageViewControllerDataSource>

@property (strong, nonatomic) UIPageViewController *pageViewController;
@property (nonatomic, strong) SlideOneViewController *oneVC;
@property (nonatomic, strong) SlideTwoViewController *twoVC;
@property (nonatomic, strong) SlideThreeViewController *threeVC;
@property (nonatomic, strong) SlideFourViewController *fourVC;
@property (nonatomic, strong) SlideFiveViewController *fiveVC;
@property (nonatomic, strong) FBLoginViewController *fbLoginVC;
@property (nonatomic, strong) UINavigationController *navController;

@end

@implementation TutorialSlidesContainerViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor backgroundGrayColor];
    self.oneVC = [[SlideOneViewController alloc] init];
    self.twoVC = [[SlideTwoViewController alloc] init];
    self.threeVC = [[SlideThreeViewController alloc] init];
    self.fourVC = [[SlideFourViewController alloc] init];
    self.fiveVC = [[SlideFiveViewController alloc] init];

    self.pageViewController = [[UIPageViewController alloc] initWithTransitionStyle:UIPageViewControllerTransitionStyleScroll navigationOrientation:UIPageViewControllerNavigationOrientationHorizontal options:nil];
    
    //self.dataSource = [[TutorialSlidesPageViewControllerDataSource alloc] init];
    self.pageViewController.dataSource = self;

    [self.pageViewController setViewControllers:@[self.oneVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
   // [self.pageViewController setViewControllers:@[[self.dataSource viewControllerAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (viewController == self.oneVC) {
        return self.twoVC;
    } else if (viewController == self.twoVC) {
        return self.threeVC;
    } else if (viewController == self.threeVC) {
        return self.fourVC;
    } else if (viewController == self.fourVC) {
        return self.fiveVC;
    } else {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        self.fbLoginVC = [storyboard instantiateViewControllerWithIdentifier:@"fbloginvc"];
        self.fbLoginVC.drawerController = self.drawerController;
        UINavigationController *navController = [[UINavigationController alloc] initWithRootViewController:self.fbLoginVC];
        return navController;
    }
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    if (viewController == self.fbLoginVC) {
        return self.fiveVC;
    } else if (viewController == self.fiveVC) {
        return self.fourVC;
    } else if (viewController == self.fourVC) {
        return self.threeVC;
    } else if (viewController == self.threeVC) {
        return self.twoVC;
    } else if (viewController == self.twoVC) {
        return self.oneVC;
    } else {
        return nil;
    }
}

@end
