//
//  DeckTagCell.h
//  cardalot
//
//  Created by Ross McIlwaine on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeckTagCell : UITableViewCell

@property (nonatomic, strong) UILabel *hashTagLabel;
@property (nonatomic, strong) UITextField *deckTagField;
@property (nonatomic, strong) UIImageView *imageView;

@end
