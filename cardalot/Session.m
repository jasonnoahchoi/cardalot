//
//  Session.m
//  cardalot
//
//  Created by sombra on 2015-03-13.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "Session.h"
#import "Deck.h"
#import "Stat.h"

@implementation Session

@dynamic startTime;
@dynamic endTime;
@dynamic markedCorrect;
@dynamic mode;
@dynamic deck;
@dynamic stats;

- (void)setModeRaw:(Mode)mode {
    [self setMode:[NSNumber numberWithInt:mode]];
}

- (Mode)modeRaw {
    return (Mode)[[self mode] intValue];
}

@end
