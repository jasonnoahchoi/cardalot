//
//  HistoryViewController.m
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CompletionViewController.h"
#import <JBChartView/JBBarChartView.h>
#import "DeckCollectionViewController.h"
#import "Deck.h"
#import "Session.h"
#import "UIColor+Colors.h"
#import "DeckCollectionViewController.h"

@interface CompletionViewController () <JBBarChartViewDataSource, JBBarChartViewDelegate>

@end

static NSString * const launchCountKey = @"launchCount";

@implementation CompletionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"Done" style:UIBarButtonItemStyleDone target:self action:@selector(done)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor whiteColor]];

    UIView *containerView = [[UIView alloc] init];
    [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:containerView];
    
    JBBarChartView *barChartView = [[JBBarChartView alloc] initWithFrame:CGRectMake(100, 120, self.view.frame.size.width - 200, self.view.frame.size.height - 200)];
    [containerView addSubview:barChartView];
    
    barChartView.dataSource = self;
    barChartView.delegate = self;
    [barChartView setMinimumValue:0];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    UILabel *leftLabel = [[UILabel alloc] init];
    [leftLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    NSInteger markedWrong = self.deck.cards.count - [self.session.markedCorrect integerValue];
    leftLabel.text = [NSString stringWithFormat:@"%ld incorrect", (long)markedWrong];
    leftLabel.numberOfLines = 0;
    leftLabel.textAlignment = NSTextAlignmentCenter;
    leftLabel.textColor = [UIColor customBlueColor];
    leftLabel.lineBreakMode = NSLineBreakByWordWrapping;
    leftLabel.layer.borderWidth = 2.0;
    leftLabel.layer.cornerRadius = 2;
    leftLabel.layer.borderColor = [[UIColor customBlueColor] CGColor];
//    leftLabel.backgroundColor = [UIColor customBlueColor];
    [footerView addSubview:leftLabel];
    UILabel *rightLabel = [[UILabel alloc] init];
    [rightLabel setTranslatesAutoresizingMaskIntoConstraints:NO];
    rightLabel.text = [NSString stringWithFormat:@"%@ correct", self.session.markedCorrect];
    rightLabel.textAlignment = NSTextAlignmentCenter;
    rightLabel.lineBreakMode = NSLineBreakByWordWrapping;
    rightLabel.textColor = [UIColor customBlueColor];
    rightLabel.numberOfLines = 0;
    rightLabel.layer.borderWidth = 2.0;
    rightLabel.layer.cornerRadius = 2;
    rightLabel.layer.borderColor = [[UIColor customBlueColor] CGColor];
//    rightLabel.backgroundColor = [UIColor customBlueColor];
    [footerView addSubview:rightLabel];
    
    if ([[UIScreen mainScreen] bounds].size.width >= 375) {
        leftLabel.font = [UIFont systemFontOfSize:13];
        rightLabel.font = [UIFont systemFontOfSize:13];
    } else {
        leftLabel.font = [UIFont systemFontOfSize:10];
        rightLabel.font = [UIFont systemFontOfSize:10];
    }
    
    barChartView.footerView = footerView;
    
    [barChartView reloadData];
    
    // AUTOLAYOUT
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(containerView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|" options:NSLayoutFormatAlignAllCenterY metrics:0 views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|" options:NSLayoutFormatAlignAllCenterX metrics:0 views:viewDictionary]];
    
    NSLayoutConstraint *leadingConstraint = [NSLayoutConstraint constraintWithItem:leftLabel attribute:NSLayoutAttributeLeading relatedBy:NSLayoutRelationEqual toItem:footerView attribute:NSLayoutAttributeLeadingMargin multiplier:1.0 constant:-8];
    [footerView addConstraint:leadingConstraint];
    
    NSLayoutConstraint *leftLabelCenterConstraint = [NSLayoutConstraint constraintWithItem:leftLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:footerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [footerView addConstraint:leftLabelCenterConstraint];
    
    NSLayoutConstraint *trailingToRightLabelConstraint = [NSLayoutConstraint constraintWithItem:leftLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:rightLabel attribute:NSLayoutAttributeLeading multiplier:1.0 constant:-10];
    [footerView addConstraint:trailingToRightLabelConstraint];
    
    NSLayoutConstraint *rightLabelCenterConstraint = [NSLayoutConstraint constraintWithItem:rightLabel attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:footerView attribute:NSLayoutAttributeCenterY multiplier:1.0 constant:0];
    [footerView addConstraint:rightLabelCenterConstraint];
    
    NSLayoutConstraint *trailingConstraint = [NSLayoutConstraint constraintWithItem:rightLabel attribute:NSLayoutAttributeTrailing relatedBy:NSLayoutRelationEqual toItem:footerView attribute:NSLayoutAttributeTrailingMargin multiplier:1.0 constant:8];
    [footerView addConstraint:trailingConstraint];
    
    NSLayoutConstraint *equalWidthConstraint = [NSLayoutConstraint constraintWithItem:leftLabel attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:rightLabel attribute:NSLayoutAttributeWidth multiplier:1.0 constant:0];
    [footerView addConstraint:equalWidthConstraint];
}

- (void)done {
    NSInteger launchCount = [[NSUserDefaults standardUserDefaults] integerForKey:launchCountKey];
    if (!launchCount)  {
        DeckCollectionViewController *deckVC = [self.navigationController.viewControllers objectAtIndex:1];
        [self.navigationController popToViewController:deckVC animated:YES];
    } else {
        [self.navigationController popToRootViewControllerAnimated:YES];
    }
}

#pragma mark JBBarChartViewDataSource
- (NSUInteger)numberOfBarsInBarChartView:(JBBarChartView *)barChartView {
    return 2;
}

#pragma mark JBBarChartViewDelegate
- (CGFloat)barChartView:(JBBarChartView *)barChartView heightForBarViewAtIndex:(NSUInteger)index {
    if (index == 0) {
        return ((float)self.deck.cards.count - [self.session.markedCorrect floatValue]);
    } else {
        return [self.session.markedCorrect floatValue];
    }
}

- (UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index {
    return [UIColor customBlueColor];
}

@end
