//
//  BackTextCell.h
//  cardalot
//
//  Created by Ross McIlwaine on 3/6/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BackTextCell : UITableViewCell <UITextViewDelegate>

@property (nonatomic, strong) UITextView *backTextView;

@end
