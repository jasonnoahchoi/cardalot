
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
@property (nonatomic, strong) UIPageControl *pageControl;

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
//    self.pageViewController.delegate = self;

    [self.pageViewController setViewControllers:@[self.oneVC] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
   // [self.pageViewController setViewControllers:@[[self.dataSource viewControllerAtIndex:0]] direction:UIPageViewControllerNavigationDirectionForward animated:YES completion:nil];
    
    
    
    [self addChildViewController:self.pageViewController];
    [self.view addSubview:self.pageViewController.view];
    [self.pageViewController didMoveToParentViewController:self];
    
//    self.pageControl = [[UIPageControl alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - 40, self.view.frame.size.width, 40)];
//    [self.view addSubview:self.pageControl];
//    self.pageControl.numberOfPages = 6;
}

-(UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    if (viewController == self.fbLoginVC) {
        return nil;
    }
    if (viewController == self.oneVC) {
        return self.twoVC;
    } else if (viewController == self.twoVC) {
        return self.threeVC;
    } else if (viewController == self.threeVC) {
        return self.fourVC;
    } else if (viewController == self.fourVC) {
        return self.fiveVC;
    } else if (viewController == self.fiveVC) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        self.fbLoginVC = [storyboard instantiateViewControllerWithIdentifier:@"fbloginvc"];
        self.fbLoginVC.drawerController = self.drawerController;
        return self.fbLoginVC;
    } else {
        return nil;
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

//-(void)pageViewController:(UIPageViewController *)pageViewController willTransitionToViewControllers:(NSArray *)pendingViewControllers {
//    
//    SlideOneViewController *oneVC = pendingViewControllers[0];
//    self.pageControl.currentPage = oneVC.inde

//    SlideTwoViewController *twoVC = pendingViewControllers[1];
//    SlideThreeViewController *threeVC = pendingViewControllers[2];
//    SlideFourViewController *fourVC = pendingViewControllers[3];
//    SlideFiveViewController *fiveVC = pendingViewControllers[4];
//    FBLoginViewController *fbVC = pendingViewControllers[5];
//}

//-(void)pageViewController:(UIPageViewController *)pageViewController didFinishAnimating:(BOOL)finished previousViewControllers:(NSArray *)previousViewControllers transitionCompleted:(BOOL)completed {
//    
//    FBLoginViewController *fbVC = previousViewControllers[0];
//    SlideFiveViewController *fiveVC = previousViewControllers[1];
//    SlideFourViewController *fourVC = previousViewControllers[2];
//    SlideThreeViewController *threeVC = previousViewControllers[3];
//    SlideTwoViewController *twoVC = previousViewControllers[4];
//    SlideOneViewController *oneVC = previousViewControllers[5];
//}

//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return 6;
//}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    return 0;
//}

@end
