//
//  HistoryViewController.m
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CompletionViewController.h"
#import <JBChartView/JBBarChartView.h>
#import "Deck.h"
#import "Session.h"
#import "UIColor+Colors.h"

@interface CompletionViewController () <JBBarChartViewDataSource, JBBarChartViewDelegate>

@end

@implementation CompletionViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithImage:[UIImage imageNamed:@"menu_icon"] style:UIBarButtonItemStylePlain target:self action:@selector(open)];
    
    
    UIView *containerView = [[UIView alloc] init];
    [containerView setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self.view addSubview:containerView];
    
    JBBarChartView *barChartView = [[JBBarChartView alloc] initWithFrame:CGRectMake(100, 120, self.view.frame.size.width - 200, self.view.frame.size.height - 200)];
    [containerView addSubview:barChartView];
    
    barChartView.dataSource = self;
    barChartView.delegate = self;
    [barChartView setMinimumValue:0];
    
    UIView *footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, 30)];
    UILabel *leftLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, 80, 30)];
    leftLabel.text = @"Left";
    leftLabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:leftLabel];
    UILabel *rightLabel = [[UILabel alloc] initWithFrame:CGRectMake(100, 0, 80, 30)];
    rightLabel.text = @"Right";
    rightLabel.textAlignment = NSTextAlignmentCenter;
    [footerView addSubview:rightLabel];
    
    barChartView.footerView = footerView;
    
    [barChartView reloadData];
    
    // AUTOLAYOUT
    NSDictionary *viewDictionary = NSDictionaryOfVariableBindings(containerView);
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"H:|[containerView]|" options:NSLayoutFormatAlignAllCenterY metrics:0 views:viewDictionary]];
    [self.view addConstraints:[NSLayoutConstraint constraintsWithVisualFormat:@"V:|[containerView]|" options:NSLayoutFormatAlignAllCenterX metrics:0 views:viewDictionary]];
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
