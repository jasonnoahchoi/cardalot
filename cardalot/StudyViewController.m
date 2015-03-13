//
//  StudyViewController.m
//  cardalot
//
//  Created by Jason Noah Choi on 3/10/15.
//  Copyright (c) 2015 Jason Choi. All rights reserved.
//

#import "StudyViewController.h"
#import "StudyDraggableViewBackground.h"
#import "Deck.h"
#import "DeckCollectionViewController.h"
#import "UIBarButtonItem+CustomButtons.h"
#import "UIColor+Colors.h"

@interface StudyViewController ()

@property (nonatomic, strong) DeckCollectionViewController *deckCollectionVC;

@end

@implementation StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
//    StudyDraggableViewBackground *draggableBackground = [[StudyDraggableViewBackground alloc] initWithFrame:self.view.frame];
//    draggableBackground.exampleCardLabels = [self.deck.cards.set allObjects];
    [self layoutNavigationBarItems];
    [self layoutSubviews];
}

- (void)layoutSubviews {
    self.draggableViewBackground = [[StudyDraggableViewBackground alloc] initWithFrame:self.view.frame];
    self.draggableViewBackground.deck = self.deck;
    [self.draggableViewBackground setExampleCardLabels:[self.deck.cards.set allObjects]];
    [self.draggableViewBackground loadCards];
    [self.view addSubview:self.draggableViewBackground];
}

- (void)layoutNavigationBarItems {
    NSString *string = [NSString stringWithFormat:@"Studying %@", self.deck.nameTag];
    self.navigationItem.title = string;

    UIImage *backIcon = [UIImage imageNamed:@"backbutton"];
    UIBarButtonItem *backButton = [[UIBarButtonItem alloc] initWithImage:backIcon style:UIBarButtonItemStylePlain target:self action:@selector(backButtonAction)];
    self.navigationItem.leftBarButtonItem = backButton;
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor customBlueColor]];

    UIImage *studyIconYellow = [UIImage imageNamed:@"Syellowicon"];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem studyButton] initWithImage:studyIconYellow style:UIBarButtonItemStylePlain target:nil action:@selector(test)];
    [self.navigationItem.rightBarButtonItem setTintColor:[UIColor customYellowColor]];
}

- (void)test {
    NSLog(@"Button");
}

- (void)backButtonAction {
    [self.navigationController popViewControllerAnimated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
