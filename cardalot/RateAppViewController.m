//
//  RateAppViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "RateAppViewController.h"
#import "DeckCollectionViewController.h"
#import "CardViewController.h"
#import <MMDrawerController.h>
#import "UIColor+Colors.h"
#import <MessageUI/MessageUI.h>

@import MessageUI;

@interface RateAppViewController () <MFMailComposeViewControllerDelegate>

@end

@implementation RateAppViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.title = @"Rate Cardalot";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCard)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
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
- (void)done {
//    [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    [self dismissViewControllerAnimated:YES completion:nil];
}

- (void)addCard {
    CardViewController *cardVC = [[CardViewController alloc] init];
    [self.navigationController pushViewController:cardVC animated:YES];
}

- (void)sendFeedbackEmail:(id)sender {
    
    MFMailComposeViewController *mailComposeViewController = [[MFMailComposeViewController alloc] init];
    mailComposeViewController.mailComposeDelegate = self;
    
    [mailComposeViewController setToRecipients:@[@"weekendconcept@gmail.com"]];
    [mailComposeViewController setSubject:@""];
    [mailComposeViewController.navigationBar setTintColor:[UIColor whiteColor]];
    
    if ([MFMailComposeViewController canSendMail]) {
        [self presentViewController:mailComposeViewController animated:YES completion:nil];
    }
}

- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error {
    
    [self dismissViewControllerAnimated:YES completion:nil];
    
}

@end
