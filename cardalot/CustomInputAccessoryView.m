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
    [indentButton setTitle:@"⇥" forState:UIControlStateNormal];
    [indentButton addTarget:self action:@selector(indent:) forControlEvents:UIControlEventTouchUpInside];
    [indentButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:indentButton];
    
    UIButton *insertBulletButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [insertBulletButton setTitle:@"•" forState:UIControlStateNormal];
    [insertBulletButton addTarget:self action:@selector(insertBullet:) forControlEvents:UIControlEventTouchUpInside];
    [insertBulletButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:insertBulletButton];
    
    UIButton *insertNumberButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [insertNumberButton setTitle:@"NUM" forState:UIControlStateNormal];
    [insertNumberButton addTarget:self action:@selector(insertNumber:) forControlEvents:UIControlEventTouchUpInside];
    [insertNumberButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:insertNumberButton];
    
    UIButton *makeBoldButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [makeBoldButton setFrame:CGRectMake(255, 0, 80, 40)];
    [makeBoldButton setTitle:@"B" forState:UIControlStateNormal];
    [makeBoldButton addTarget:self action:@selector(makeBold:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:makeBoldButton];
    
    UIButton *leftArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [leftArrowButton setTitle:@"⍇" forState:UIControlStateNormal];
    [leftArrowButton addTarget:self action:@selector(moveLeft:) forControlEvents:UIControlEventTouchUpInside];
    [leftArrowButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:leftArrowButton];
    
    UIButton *rightArrowButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [rightArrowButton setTitle:@"⍈" forState:UIControlStateNormal];
    [rightArrowButton addTarget:self action:@selector(moveRight:) forControlEvents:UIControlEventTouchUpInside];
    [rightArrowButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:rightArrowButton];
    
    UIButton *pasteButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [pasteButton setFrame:CGRectMake(335, 0, 80, 40)];
    [pasteButton setTitle:@"📋" forState:UIControlStateNormal];
    [pasteButton addTarget:self action:@selector(paste:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:pasteButton];
    
    UIButton *copyButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [copyButton setFrame:CGRectMake(0, 0, 80, 40)];
    [copyButton setTitle:@"📝" forState:UIControlStateNormal];
    [copyButton addTarget:self action:@selector(copy:) forControlEvents:UIControlEventTouchUpInside];
//    [self addSubview:copyButton];
    
    UIButton *doneButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [doneButton setTitle:@"⌨" forState:UIControlStateNormal];
    [doneButton addTarget:self action:@selector(done:) forControlEvents:UIControlEventTouchUpInside];
    [doneButton setTranslatesAutoresizingMaskIntoConstraints:NO];
    [self addSubview:doneButton];
    
    // AUTOLAYOUT
    NSDictionary *viewsDictionary = NSDictionaryOfVariableBindings(indentButton, insertBulletButton, insertNumberButton, leftArrowButton, rightArrowButton, doneButton);
    
    NSArray *constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|-(==20)-[indentButton]-(==50)-[insertBulletButton]-[insertNumberButton]-(==40)-[leftArrowButton][rightArrowButton]-[doneButton]-(==20)-|" options:NSLayoutFormatAlignAllCenterY metrics:nil views:viewsDictionary];
    [self addConstraints:constraints];
    
    constraints = [NSLayoutConstraint constraintsWithVisualFormat:@"V:|-[indentButton]-|" options:0 metrics:nil views:viewsDictionary];
    [self addConstraints:constraints];
    
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

- (IBAction)done:(id)sender {
    [(UITextView *)self.delegate resignFirstResponder];
}

@end
