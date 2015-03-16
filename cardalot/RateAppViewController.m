//
//  RateAppViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "RateAppViewController.h"
#import "DeckCollectionViewController.h"
#import <MMDrawerController.h>
#import "UIColor+Colors.h"

@import MessageUI;

@interface RateAppViewController ()

@end

@implementation RateAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Rate Cardalot";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    
    UILabel *rateAppMessageLabel = [[UILabel alloc] init];
    rateAppMessageLabel.text = @"We are sorry that you decide not to rate our app. We are constantly looking for ways to improve in order to provide you with the best experience possible. Please consider sending us a support email to let us know where and how we can improve.";
    rateAppMessageLabel.numberOfLines = 0;
    [rateAppMessageLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:rateAppMessageLabel];
    
    UIButton *composeEmailButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [composeEmailButton setTitle:@"Send feedback" forState:UIControlStateNormal];
    [composeEmailButton setTitleColor:[UIColor customBlueColor] forState:UIControlStateNormal];
    [composeEmailButton addTarget:self action:@selector(sendFeedbackEmail:) forControlEvents:UIControlEventTouchUpInside];
    [composeEmailButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:composeEmailButton];
    
    // AUTOLAYOUT
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:rateAppMessageLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:100];
    [self.view addConstraint:topConstraint];
    
    NSLayoutConstraint *rateAppMessageLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:rateAppMessageLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    [self.view addConstraint:rateAppMessageLabelLeadingConstraint];
    
    NSLayoutConstraint *rateAppMessageLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:rateAppMessageLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    [self.view addConstraint:rateAppMessageLabelTrailingConstraint];
    
    NSLayoutConstraint *rateAppMessageLabelBottomConstraint = [NSLayoutConstraint constraintWithItem:rateAppMessageLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:composeEmailButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:-20];
    [self.view addConstraint:rateAppMessageLabelBottomConstraint];
    
    NSLayoutConstraint *composeEmailButtonLeadingConstraint = [NSLayoutConstraint constraintWithItem:composeEmailButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    [self.view addConstraint:composeEmailButtonLeadingConstraint];
    
    NSLayoutConstraint *composeEmailButtonTrailingConstraint = [NSLayoutConstraint constraintWithItem:composeEmailButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    [self.view addConstraint:composeEmailButtonTrailingConstraint];
}

#pragma mark - Actions
- (void)open {
    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
}

- (IBAction)sendFeedbackEmail:(id)sender {
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];

    [mailComposeViewController setToRecipients:@[@"weekendconcept@gmail.com"]];
    
    if ([MFMailComposeViewController canSendMail]) {
        [self presentViewController:mailComposeViewController animated:YES completion:nil];
    }
}

@end
