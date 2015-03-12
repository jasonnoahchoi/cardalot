//
//  CustomInputAccessoryView.m
//  cardalot
//
//  Created by sombra on 2015-03-11.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CustomInputAccessoryView.h"

@implementation CustomInputAccessoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.backgroundColor = [UIColor colorWithHue:204.0/360 saturation:.78 brightness:.66 alpha:1.0];
    
    UIButton *indentButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [indentButton setFrame:CGRectMake(0, 0, 80, 40)];
    [indentButton setTitle:@"⇥" forState:UIControlStateNormal];
    [indentButton addTarget:self action:@selector(indent:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:indentButton];
    
    UIButton *insertBulletButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [insertBulletButton setFrame:CGRectMake(85, 0, 80, 40)];
    [insertBulletButton setTitle:@"•" forState:UIControlStateNormal];
    [insertBulletButton addTarget:self action:@selector(insertBullet:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:insertBulletButton];
    
    UIButton *insertNumberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [insertNumberButton setFrame:CGRectMake(175, 0, 80, 40)];
    [insertNumberButton setTitle:@"NUM" forState:UIControlStateNormal];
    [insertNumberButton addTarget:self action:@selector(insertNumber:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:insertNumberButton];
    
    UIButton *makeBoldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [makeBoldButton setFrame:CGRectMake(255, 0, 80, 40)];
    [makeBoldButton setTitle:@"B" forState:UIControlStateNormal];
    [makeBoldButton addTarget:self action:@selector(makeBold:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:makeBoldButton];
    
    return self;
}

- (IBAction)indent:(id)sender {
    [self.delegate insertText:@"     "];
}

- (IBAction)insertBullet:(id)sender {
    [self.delegate insertText:@"•  "];
}

- (IBAction)insertNumber:(id)sender {
    
}

- (IBAction)makeBold:(id)sender {
    UIFont *boldFont = [UIFont boldSystemFontOfSize:20];
    
    NSDictionary *boldAttr = @{NSFontAttributeName: boldFont};
    UITextRange *selectedTextRange = [self.delegate selectedTextRange];
    NSString *selectedText = [self.delegate textInRange:selectedTextRange];
    NSMutableAttributedString *attributedText = [[NSMutableAttributedString alloc] initWithString:selectedText attributes:boldAttr];
    NSString *boldText = [attributedText string];
    
    [self.delegate replaceRange:selectedTextRange withText:boldText];
    
}

@end
