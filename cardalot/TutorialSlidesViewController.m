//
//  TutorialSlidesViewController.m
//  cardalot
//
//  Created by sombra on 2015-03-19.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "TutorialSlidesViewController.h"
#import "ImageController.h"

@interface TutorialSlidesViewController ()

@end

@implementation TutorialSlidesViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[ImageController sharedInstance].images[self.index]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:imageView];
    
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(imageView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageView]-|" options:0 metrics:0 views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageView]-|" options:0 metrics:0 views:viewDictionary]];
}


@end
