//
//  PrivacyViewController.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/19/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "PrivacyViewController.h"
@import WebKit;

@interface PrivacyViewController ()

@end

@implementation PrivacyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemDone target:self action:@selector(dismiss)];
    self.navigationItem.leftBarButtonItem.tintColor = [UIColor whiteColor];
    WKWebView *webView = [[WKWebView alloc] initWithFrame:CGRectMake(0, 64, self.view.frame.size.width, self.view.frame.size.height - 64)];
    NSString *htmlForView = [NSString stringWithContentsOfURL:[[NSBundle mainBundle] URLForResource:@"privacy" withExtension:@"html"] encoding:NSStringEncodingConversionAllowLossy error:nil];
    [webView loadHTMLString:htmlForView baseURL:[[NSBundle mainBundle] URLForResource:@"privacy" withExtension:@"html"]];

    [self.view addSubview:webView];
}

- (void)dismiss {
    [self.navigationController popViewControllerAnimated:YES];
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
