//
//  TutorialSlidesViewController.h
//  cardalot
//
//  Created by sombra on 2015-03-19.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface TutorialSlidesViewController : UIViewController

@property (nonatomic, assign) NSInteger index;
@property (nonatomic, strong) UIImage *image;
@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end
