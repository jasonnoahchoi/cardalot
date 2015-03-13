//
//  StatsTableViewCell.h
//  cardalot
//
//  Created by sombra on 2015-03-12.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <JBChartView/JBLineChartView.h>

@interface StatsTableViewCell : UITableViewCell <JBLineChartViewDataSource, JBLineChartViewDelegate>

@property (weak, nonatomic) IBOutlet UIView *containerView;

@end
