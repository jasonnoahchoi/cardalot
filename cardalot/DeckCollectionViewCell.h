//
//  DeckCollectionViewCell.h
//  cardalot
//
//  Created by Jason Noah Choi on 3/7/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface DeckCollectionViewCell : UICollectionViewCell

@property (strong, nonatomic) IBOutlet UILabel *subjectLabel;
@property (weak, nonatomic) IBOutlet UIButton *closeButton;

- (void)startJiggling;
- (void)stopJiggling;

@end
