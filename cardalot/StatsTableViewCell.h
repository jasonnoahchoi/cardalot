//
//  StatsTableViewCell.h
//  cardalot
//
//  Created by sombra on 2015-03-12.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JBChartView/JBLineChartView.h>

@class Deck;

@interface StatsTableViewCell : UITableViewCell <JBLineChartViewDataSource, JBLineChartViewDelegate>

@property (strong, nonatomic) Deck *deck;
@property (strong, nonatomic) JBLineChartView *lineChartView;
@property (strong, nonatomic) UILabel *chartTitle;

@end
