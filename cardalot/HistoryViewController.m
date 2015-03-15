//
//  HistoryViewController.m
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "HistoryViewController.h"
#import <JBChartView/JBBarChartView.h>
#import "DeckCollectionViewController.h"

@interface HistoryViewController () <JBBarChartViewDataSource, JBBarChartViewDelegate>

@end

@implementation HistoryViewController

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
        return 31;
    } else {
        return 55;
    }
}

- (UIColor *)barChartView:(JBBarChartView *)barChartView colorForBarViewAtIndex:(NSUInteger)index {
    return [UIColor colorWithHue:204.0/360 saturation:.78 brightness:.66 alpha:1.0];
}

@end
