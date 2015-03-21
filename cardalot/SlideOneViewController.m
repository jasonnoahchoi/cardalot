//
//  SlideOneViewController.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/20/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "SlideOneViewController.h"
#import "ImageController.h"

@interface SlideOneViewController ()

@end

@implementation SlideOneViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[ImageController sharedInstance].images[0]]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];

//    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(imageView);
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|-[imageView]-|" options:0 metrics:0 views:viewDictionary]];
//    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[imageView]-|" options:0 metrics:0 views:viewDictionary]];
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
