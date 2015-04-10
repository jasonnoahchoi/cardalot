//
//  ReferralViewController.m
//  cardalot
//
//  Created by Ross McIlwaine on 3/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "ReferralViewController.h"
#import "DeckCollectionViewController.h"
#import "CardViewController.h"
#import <MMDrawerController.h>
#import "UIColor+Colors.h"
@import MessageUI;
@import QuartzCore;

@interface ReferralViewController () <MFMessageComposeViewControllerDelegate, UITextFieldDelegate>

@property (nonatomic, strong) UITextView *textView;
@end

@implementation ReferralViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"Refer Friends";
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemAdd target:self action:@selector(addCard)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor whiteColor]];
    
    UILabel *referFriendsLabel = [[UILabel alloc] init];
    referFriendsLabel.text = @"If you enjoy using Cardalot, would you mind taking a moment to tell your friends about it? We hope it helps them as much as it has helped you! Feel free to edit the message below and click send messsage. You'll have the option to send it out in multiple ways.";
    referFriendsLabel.numberOfLines = 0;
    [referFriendsLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:referFriendsLabel];

    self.textView = [[UITextView alloc] initWithFrame:CGRectMake(self.view.frame.size.width/6, self.view.frame.size.height/2.5, CGRectGetWidth(self.view.frame) - (CGRectGetWidth(self.view.frame)/6) * 2, CGRectGetHeight(self.view.frame)/8)];
    [self.view addSubview:self.textView];
    self.textView.backgroundColor = [UIColor lightGrayColor];
    self.textView.layer.borderColor = [UIColor darkGrayColor].CGColor;
    self.textView.layer.borderWidth = 3;
    self.textView.layer.cornerRadius = 5;

    self.textView.text = @"Hey check out this cool app called Cardalot! It will help you learn easily! https://appsto.re/us/CPTw6.i";
    
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
    
    NSLayoutConstraint *referFriendsLabelBottomConstraint = [NSLayoutConstraint constraintWithItem:referFriendsLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:sendMessageButton attribute:NSLayoutAttributeTop multiplier:1.0 constant:-150];
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

- (void)addCard {
    CardViewController *cardVC = [[CardViewController alloc] init];
    [self.navigationController pushViewController:cardVC animated:YES];
}

- (void)composeMessage {
    ///CHANGE THISSSS
    NSString *shareString = self.textView.text;


    NSArray * itemsArray = @[[NSString stringWithFormat:@"%@",shareString]];//if you want to share image here pass url of image in the array.

    NSArray * applicationActivities = nil;
    UIActivityViewController * AVC = [[UIActivityViewController alloc] initWithActivityItems:itemsArray applicationActivities:applicationActivities];


    [self presentViewController:AVC animated:YES completion:nil];
    [AVC setCompletionHandler:^(NSString *act, BOOL done)
     {

         NSString *ServiceMsg = shareString;

         if([act isEqualToString:UIActivityTypeMail]) {
             ServiceMsg = @"Mail sent!";
         } else if([act isEqualToString:UIActivityTypePostToTwitter]) {
             ServiceMsg = @"Shared on twitter!";
         } else if([act isEqualToString:UIActivityTypePostToFacebook]) {
             ServiceMsg = @"Shared on facebook!";
         } else if([act isEqualToString:UIActivityTypeMessage]) {
             ServiceMsg = @"SMS sent!";
         } else if([act isEqualToString:UIActivityTypeAddToReadingList]) {
             ServiceMsg = @"Added to Reading List";
         } else if([act isEqualToString:UIActivityTypeCopyToPasteboard]){
             ServiceMsg = @"Link Copied";
         }

         if ( done )
         {
             UIAlertView *Alert = [[UIAlertView alloc] initWithTitle:ServiceMsg message:@"" delegate:nil cancelButtonTitle:@"ok" otherButtonTitles:nil];
             [Alert show];
             
         }
     }];

//    MFMessageComposeViewController *messageComposeViewController = [[MFMessageComposeViewController alloc] init];
//    messageComposeViewController.messageComposeDelegate = self;
//    
//    [messageComposeViewController setBody:@"Hey check out this cool app called Cardalot! It will help you learn easily! https://appsto.re/us/CPTw6.i"];
//    [messageComposeViewController.navigationBar setTintColor:[UIColor whiteColor]];
//    
//    if ([MFMessageComposeViewController canSendText]) {
//        [self presentViewController:messageComposeViewController animated:YES completion:nil];

}

- (BOOL)textFieldShouldReturn:(UITextField *)textField {
    [textField resignFirstResponder];
    return YES;
}
#pragma mark - MFMessageComposeViewControllerDelegate
- (void)messageComposeViewController:(MFMessageComposeViewController *)controller didFinishWithResult:(MessageComposeResult)result {
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
