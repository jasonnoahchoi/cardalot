//
//  SlideFourViewController.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/20/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "SlideFourViewController.h"
#import "ImageController.h"

@interface SlideFourViewController ()

@end

@implementation SlideFourViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:[ImageController sharedInstance].images[3]]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];

    // Do any additional setup after loading the view.
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
