//
//  StudyViewController.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "StudyViewController.h"
#import "StudyDraggableViewBackground.h"

@interface StudyViewController ()

@end

@implementation StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    StudyDraggableViewBackground *draggableBackground = [[StudyDraggableViewBackground alloc] initWithFrame:self.view.frame];
    [self.view addSubview:draggableBackground];

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
