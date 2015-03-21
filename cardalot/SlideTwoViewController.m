//
//  SlideTwoViewController.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/20/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "SlideTwoViewController.h"
#import "ImageController.h"

@interface SlideTwoViewController ()

@end

@implementation SlideTwoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    UIImageView *imageView = [[UIImageView alloc] initWithImage:[ImageController sharedInstance].images[1]];
    imageView.contentMode = UIViewContentModeScaleAspectFit;
    [imageView setTranslatesAutoresizingMaskIntoConstraints:NO];
    imageView.frame = self.view.bounds;
    [self.view addSubview:imageView];

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
