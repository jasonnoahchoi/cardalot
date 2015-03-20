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


- (TutorialSlidesViewController *)initialViewController {
    TutorialSlidesViewController *tutorialVC = [[TutorialSlidesViewController alloc] init];
    tutorialVC.index = 0;
    return tutorialVC;
}

- (UIViewController *)viewControllerAtIndex:(NSInteger)index {
    if (index < 0 || index >= [ImageController sharedInstance].images.count + 1) {
        return nil;
    } else if (index == 5) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        FBLoginViewController *fbLoginVC = [storyboard instantiateViewControllerWithIdentifier:@"fbloginvc"];
        return fbLoginVC;
    }

    TutorialSlidesViewController *tutorialVC = [[TutorialSlidesViewController alloc] init];
    tutorialVC.index = index;
    tutorialVC.image = [ImageController sharedInstance].images[index];
    return tutorialVC;
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerAfterViewController:(UIViewController *)viewController {
    NSInteger index = ((TutorialSlidesViewController *)viewController).index + 1;
    if (index == 5) {
        UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:[NSBundle mainBundle]];
        FBLoginViewController *fbLoginVC = [storyboard instantiateViewControllerWithIdentifier:@"fbloginvc"];
        return fbLoginVC;
    }
    return [self viewControllerAtIndex:index];
}

- (UIViewController *)pageViewController:(UIPageViewController *)pageViewController viewControllerBeforeViewController:(UIViewController *)viewController {
    NSInteger index = ((TutorialSlidesViewController *)viewController).index - 1;
    return [self viewControllerAtIndex:index];
}

//- (NSInteger)presentationCountForPageViewController:(UIPageViewController *)pageViewController {
//    return 6;
//}
//
//- (NSInteger)presentationIndexForPageViewController:(UIPageViewController *)pageViewController {
//    return 0;
//}

@end
