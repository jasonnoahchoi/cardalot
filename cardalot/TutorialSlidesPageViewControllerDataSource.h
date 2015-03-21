//
//  TutorialSlidesPageViewControllerDataSource.h
//  cardalot
//
//  Created by sombra on 2015-03-19.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

@import UIKit;
@class TutorialSlidesViewController;

@interface TutorialSlidesPageViewControllerDataSource : NSObject <UIPageViewControllerDataSource>

- (UIViewController *)viewControllerAtIndex:(NSInteger)index;

@end
