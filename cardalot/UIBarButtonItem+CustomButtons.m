//
//  UIBarButtonItem+CustomButtons.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/12/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "UIBarButtonItem+CustomButtons.h"
#import "UIColor+Colors.h"
@implementation UIBarButtonItem (CustomButtons)

+ (UIBarButtonItem *)studyButton {
    UIImage *studyIconGray = [UIImage imageNamed:@"Sgrayicon"];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:studyIconGray style:UIBarButtonItemStylePlain target:self action:@selector(studyMode)];
    [button setTintColor:[UIColor customGrayColor]];
    return button;
}

+ (UIBarButtonItem *)quizButton:(UIImage *)image target:(id)target action:(SEL)action {
     UIImage *quizIconGray = [UIImage imageNamed:@"Qgrayicon"];
    UIBarButtonItem *button = [[UIBarButtonItem alloc] initWithImage:quizIconGray style:UIBarButtonItemStylePlain target:self action:@selector(quizMode)];
    [button setTintColor:[UIColor customGrayColor]];
    return button;

}

@end
