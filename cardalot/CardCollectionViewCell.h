//
//  CardCollectionViewCell.h
//  cardalot
//
//  Created by sombra on 2015-03-08.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@class Card;

@interface CardCollectionViewCell : UICollectionViewCell

@property (nonatomic, strong) UITextField *textField;
@property (nonatomic, strong) UITextView *textView;
@property (nonatomic, strong) Card *card;

@end
