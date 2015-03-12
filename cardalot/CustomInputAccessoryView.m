//
//  CustomInputAccessoryView.m
//  cardalot
//
//  Created by sombra on 2015-03-11.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "CustomInputAccessoryView.h"

@interface CustomInputAccessoryView ()

@property (assign, nonatomic) NSInteger index;

@end

@implementation CustomInputAccessoryView

- (instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    
    self.index = 1;
    
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
    
    UIButton *leftArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftArrowButton setFrame:CGRectMake(335, 0, 80, 40)];
    [leftArrowButton setTitle:@"⍇" forState:UIControlStateNormal];
    [leftArrowButton addTarget:self action:@selector(moveLeft:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:leftArrowButton];
    
    UIButton *rightArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightArrowButton setFrame:CGRectMake(335, 0, 80, 40)];
    [rightArrowButton setTitle:@"⍈" forState:UIControlStateNormal];
    [rightArrowButton addTarget:self action:@selector(moveRight:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:rightArrowButton];
    
    UIButton *pasteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pasteButton setFrame:CGRectMake(335, 0, 80, 40)];
    [pasteButton setTitle:@"📋" forState:UIControlStateNormal];
    [pasteButton addTarget:self action:@selector(paste:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:pasteButton];
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyButton setFrame:CGRectMake(0, 0, 80, 40)];
    [copyButton setTitle:@"📝" forState:UIControlStateNormal];
    [copyButton addTarget:self action:@selector(copy:) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:copyButton];
    
    return self;
}

- (IBAction)indent:(id)sender {
    [self.delegate insertText:@"     "];
}

- (IBAction)insertBullet:(id)sender {
    [self.delegate insertText:@"•  "];
}

- (IBAction)insertNumber:(id)sender {
    [self.delegate insertText:[NSString stringWithFormat:@"%ld. ", (long)self.index]];
    self.index++;
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

- (IBAction)moveLeft:(id)sender {
    UITextRange *selectedRange = [self.delegate selectedTextRange];
    UITextPosition *startPosition = [self.delegate positionFromPosition:[(UITextView *)self.delegate beginningOfDocument] offset:0];
    
    if (![(UITextView *)self.delegate offsetFromPosition:selectedRange.start toPosition:startPosition] == 0) {
        UITextPosition *newPosition = [(UITextView *)self.delegate positionFromPosition:selectedRange.start offset:-1];
        UITextRange *newRange = [(UITextView *)self.delegate textRangeFromPosition:newPosition toPosition:newPosition];
        
        [(UITextView *)self.delegate setSelectedTextRange:newRange];
    }
}

- (IBAction)moveRight:(id)sender {
    UITextRange *selectedRange = [self.delegate selectedTextRange];
    UITextPosition *startPosition = [self.delegate positionFromPosition:[(UITextView *)self.delegate beginningOfDocument] offset:0];
    
    if (![(UITextView *)self.delegate offsetFromPosition:selectedRange.start toPosition:startPosition] == 0) {
        UITextPosition *newPosition = [(UITextView *)self.delegate positionFromPosition:selectedRange.start offset:1];
        UITextRange *newRange = [(UITextView *)self.delegate textRangeFromPosition:newPosition toPosition:newPosition];
        
        [(UITextView *)self.delegate setSelectedTextRange:newRange];
    }
}

- (IBAction)paste:(id)sender {
    [self.delegate insertText:[[UIPasteboard generalPasteboard] string]];
}

- (IBAction)copy:(id)sender {
    UITextRange *selectedTextRange = [self.delegate selectedTextRange];
    NSString *selectedText = [self.delegate textInRange:selectedTextRange];
    [[UIPasteboard generalPasteboard] setString:selectedText];
}

@end
