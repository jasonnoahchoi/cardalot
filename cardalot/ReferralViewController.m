//
//  ReferralViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "ReferralViewController.h"
#import "DeckCollectionViewController.h"
#import <MMDrawerController.h>
#import "UIColor+Colors.h"
@import MessageUI;

@interface ReferralViewController () <MFMessageComposeViewControllerDelegate>

@end

@implementation ReferralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Refer Friends";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    UILabel *referFriendsLabel = [[UILabel alloc] init];
    referFriendsLabel.text = @"If you enjoy using Cardalot, would you mind taking a moment to tell your friends about it? This would be very helpful for them as Cardalot would help them learn stuff the way it has helped you. So please consider telling your friends about Cardalot.";
    referFriendsLabel.numberOfLines = 0;
    [referFriendsLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:referFriendsLabel];
    
    UIButton *sendMessageButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [sendMessageButton setTitle:@"Send Message" forState:UIControlStateNormal];
    [sendMessageButton setTitleColor:[UIColor customBlueColor] forState:UIControlStateNormal];
    [sendMessageButton setTitleColor:[[UIColor customBlueColor] colorWithAlphaComponent:0.7] forState:UIControlStateHighlighted];
    [sendMessageButton addTarget:self action:@selector(composeMessage) forControlEvents:UIControlEventTouchUpInside];
    [sendMessageButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:sendMessageButton];
    
    // AUTOLAYOUT
    NSLayoutConstraint *topConstraint = [NSLayoutConstraint constraintWithItem:referFriendsLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTopMargin multiplier:1.0 constant:100];
    [self.view addConstraint:topConstraint];
    
    NSLayoutConstraint *referFriendsLabelLeadingConstraint = [NSLayoutConstraint constraintWithItem:referFriendsLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    [self.view addConstraint:referFriendsLabelLeadingConstraint];
    
    NSLayoutConstraint *referFriendsLabelTrailingConstraint = [NSLayoutConstraint constraintWithItem:referFriendsLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    [self.view addConstraint:referFriendsLabelTrailingConstraint];
    
    NSLayoutConstraint *referFriendsLabelBottomConstraint = [NSLayoutConstraint constraintWithItem:referFriendsLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:sendMessageButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:-20];
    [self.view addConstraint:referFriendsLabelBottomConstraint];
    
    NSLayoutConstraint *sendMessageButtonLeadingConstraint = [NSLayoutConstraint constraintWithItem:sendMessageButton attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:0];
    [self.view addConstraint:sendMessageButtonLeadingConstraint];
    
    NSLayoutConstraint *sendMessageButtonTrailingConstraint = [NSLayoutConstraint constraintWithItem:sendMessageButton attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:self.view attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:0];
    [self.view addConstraint:sendMessageButtonTrailingConstraint];
    
}

- (void)open {
    if (self.drawerController.openSide) {
        [self.drawerController closeDrawerAnimated:YES completion:nil];
    } else {
        [self.drawerController openDrawerSide:MMDrawerSideLeft animated:YES completion:nil];
    }
}

- (void)composeMessage {
    MFMessageComposeViewController *messageComposeViewController = [[MFMessageComposeViewController alloc] init];
    messageComposeViewController.messageComposeDelegate = self;
    
    if ([MFMessageComposeViewController canSendText]) {
        [self presentViewController:messageComposeViewController animated:YES completion:nil];
    }
}

#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
