//
//  TutorialSlidesPageViewControllerDataSource.m
//  cardalot
//
//  Created by sombra on 2015-03-19.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "TutorialSlidesPageViewControllerDataSource.h"
#import "TutorialSlidesViewController.h"
#import "ImageController.h"
#import "FBLoginViewController.h"

@implementation TutorialSlidesPageViewControllerDataSource

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = ((TutorialSlidesViewController *)viewController).index + 1;
    TutorialSlidesViewController *tutorialVC = (TutorialSlidesViewController *)[self viewControllerAtIndex:index];
    return tutorialVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = ((TutorialSlidesViewController *)viewController).index - 1;
    TutorialSlidesViewController *tutorialVC = (TutorialSlidesViewController *)[self viewControllerAtIndex:index];
    return tutorialVC;
}

- (TutorialSlidesViewController *)initialViewController {
    TutorialSlidesViewController *tutorialVC = [[TutorialSlidesViewController alloc] init];
    tutorialVC.index = 0;
    return tutorialVC;
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index {
    if (index < 0 || index >= [ImageController sharedInstance].images.count + 1) {
        return nil;
    } else if (index == 5) {
        FBLoginViewController *fbLogin = [[FBLoginViewController alloc] init];
        return fbLogin;
    }

    TutorialSlidesViewController *tutorialVC = [[TutorialSlidesViewController alloc] init];
    tutorialVC.index = index;
    tutorialVC.image = [ImageController sharedInstance].images[index];
    return tutorialVC;
}

//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return 6;
//}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    return 0;
//}

@end
