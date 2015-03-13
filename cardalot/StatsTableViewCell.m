//
//  StatsTableViewCell.m
//  cardalot
//
//  Created by sombra on 2015-03-12.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "StatsTableViewCell.h"
#import "Deck.h"
#import "Quiz.h"
#import "Study.h"

@implementation StatsTableViewCell

- (void)awakeFromNib {
    
    JBLineChartView *lineChartView = [[JBLineChartView alloc] init];
    lineChartView.dataSource = self;
    lineChartView.delegate = self;
    lineChartView.backgroundColor = [UIColor darkGrayColor];
    [self.containerView addSubview:lineChartView];
    
    lineChartView.frame = self.containerView.frame;
    [lineChartView reloadData];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    headerView.backgroundColor = [UIColor grayColor];
    UILabel *chartTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.containerView.frame.size.width, 30)];
    chartTitle.text = @"Deck";
//    chartTitle.text = self.deck.nameTag;
    chartTitle.textColor = [UIColor whiteColor];
    chartTitle.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:chartTitle];
    lineChartView.headerView = headerView;
}

#pragma mark JBLineChartViewDataSource
- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView {
    return 2;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex {
//    if (lineIndex == 0) {
//        return self.deck.quizzes.count;
//    } else {
//        return self.deck.studies.count;
//    }
    return 5;
}

#pragma mark JBLineChartViewDelegate
- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    
//    CGFloat totalCards = self.deck.cards.count;
    if (lineIndex == 0) {
//        Quiz *quiz = self.deck.quizzes[horizontalIndex];
//        CGFloat percentCorrect = [quiz.right floatValue]/totalCards;
//        return percentCorrect;
        NSArray *data = @[@34, @67, @12, @85, @55];
        return [data[horizontalIndex] floatValue];
    } else {
//        Study *study = self.deck.studies[horizontalIndex];
//        CGFloat percentCorrect = [study.right floatValue]/totalCards;
//        return percentCorrect;
        NSArray *data = @[@93, @33, @47, @9, @78];
        return [data[horizontalIndex] floatValue];
    }
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex {
    if (lineIndex == 0) {
        return [UIColor colorWithHue:204.0/360 saturation:.78 brightness:.66 alpha:1.0];
    } else {
        return [UIColor orangeColor];
    }
}
@end
