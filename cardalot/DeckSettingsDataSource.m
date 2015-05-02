//
//  DeckSettingsDataSource.m
//  cardalot
//
//  Created by sombra on 2015-04-11.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "DeckSettingsDataSource.h"
#import "DeckTagCell.h"
#import "StatsTableViewCell.h"
#import "DeckController.h"
#import "Deck.h"

@interface DeckSettingsDataSource () <UITextFieldDelegate>

@property (strong, nonatomic) UITableViewCell *cardCountCell;
@property (strong, nonatomic) DeckTagCell *deckTagCell;

@end

typedef enum : NSUInteger {
    DeckNameSection,
    DeckStatsSection,
} Section;

@implementation DeckSettingsDataSource

- (instancetype)initWithDeck:(Deck *)deck
{
    self = [super init];
    if (self) {
        self.deck = deck;
        
        self.deckTagCell = [[DeckTagCell alloc] init];
        self.deckTagCell.deckTagField.text = self.deck.nameTag;
        self.deckTagCell.deckTagField.delegate = self;
        
        self.cardCountCell = [[UITableViewCell alloc] init];
        self.cardCountCell.textLabel.text = [NSString stringWithFormat:@"%lu cards in %@", (unsigned long)self.deck.cards.count, self.deck.nameTag];
        self.cardCountCell.textLabel.textAlignment = NSTextAlignmentCenter;
    }
    return self;
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.section) {
        case DeckNameSection:
            return self.deckTagCell;
            break;
        case DeckStatsSection:
            return self.cardCountCell;
            break;
        default:
            return [[UITableViewCell alloc] init];
            break;
    }
}

#pragma mark - UITextFieldDelegate

- (void)textFieldDidEndEditing:(UITextField *)textField {
    self.deck.nameTag = self.deckTagCell.deckTagField.text;
    [[DeckController sharedInstance] save];
}

@end
