//
//  StatsTableViewCell.m
//  cardalot
//
//  Created by sombra on 2015-03-12.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "StatsTableViewCell.h"
#import "Deck.h"
#import "Session.h"
#import "UIColor+Colors.h"

@interface StatsTableViewCell ()

@property (strong, nonatomic) NSArray *quizSessions;
@property (strong, nonatomic) NSArray *studySessions;

@end

@implementation StatsTableViewCell

- (void)awakeFromNib {
    
    JBLineChartView *lineChartView = [[JBLineChartView alloc] init];
    lineChartView.dataSource = self;
    lineChartView.delegate = self;
    lineChartView.backgroundColor = [UIColor customGrayColor];
    
    lineChartView.layer.borderWidth = 3.0;
    lineChartView.layer.cornerRadius = 5;
    lineChartView.layer.borderColor = [[UIColor customBlueColor] CGColor];
    
    [self.containerView addSubview:lineChartView];
    
    lineChartView.frame = self.containerView.frame;
    [lineChartView reloadData];
    
    UIView *headerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 100, 30)];
    headerView.backgroundColor = [UIColor customYellowColor];
    UILabel *chartTitle = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, self.containerView.frame.size.width, 30)];
    chartTitle.text = self.deck.nameTag;
    chartTitle.textColor = [UIColor whiteColor];
    chartTitle.textAlignment = NSTextAlignmentCenter;
    [headerView addSubview:chartTitle];
    lineChartView.headerView = headerView;
}

- (NSArray *)quizSessions {
    NSMutableArray *mutableQuizSessions = [NSMutableArray array];
    for (Session *session in self.deck.sessions) {
        if ([session.mode intValue] == 0) {
            [mutableQuizSessions addObject:session];
        }
    }
    return mutableQuizSessions;
}

- (NSArray *)studySessions {
    NSMutableArray *mutableStudySessions = [NSMutableArray array];
    for (Session *session in self.deck.sessions) {
        if ([session.mode intValue] == 1) {
            [mutableStudySessions addObject:session];
        }
    }
    return mutableStudySessions;
}

#pragma mark JBLineChartViewDataSource
- (NSUInteger)numberOfLinesInLineChartView:(JBLineChartView *)lineChartView {
    return 2;
}

- (NSUInteger)lineChartView:(JBLineChartView *)lineChartView numberOfVerticalValuesAtLineIndex:(NSUInteger)lineIndex {
    if (lineIndex == 0) {
        return self.quizSessions.count;
    } else {
        return self.studySessions.count;
    }
}

#pragma mark JBLineChartViewDelegate
- (CGFloat)lineChartView:(JBLineChartView *)lineChartView verticalValueForHorizontalIndex:(NSUInteger)horizontalIndex atLineIndex:(NSUInteger)lineIndex {
    
    CGFloat totalCards = self.deck.cards.count;
    if (lineIndex == 0) {
        Session *session = self.quizSessions[horizontalIndex];
        CGFloat percentCorrect = [session.markedCorrect floatValue]/totalCards;
        return percentCorrect;
    } else {
        Session *session = self.studySessions[horizontalIndex];
        CGFloat percentCorrect = [session.markedCorrect floatValue]/totalCards;
        return percentCorrect;
    }
}

- (UIColor *)lineChartView:(JBLineChartView *)lineChartView colorForLineAtLineIndex:(NSUInteger)lineIndex {
    if (lineIndex == 0) {
        return [UIColor customOrangeColor];
    } else {
        return [UIColor customBlueColor];
    }
}
@end
