//
//  LogoMenuCell.h
//  cardalot
//
//  Created by Ross McIlwaine on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LogoMenuCell : UITableViewCell <UITableViewDelegate>

@property (nonatomic, strong) UIImageView *logoImage;
@property (nonatomic, strong) UILabel *decktagLabel;

@end
