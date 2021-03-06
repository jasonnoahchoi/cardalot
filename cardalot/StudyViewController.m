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
#import "DeckController.h"

@interface StudyViewController ()

@property (nonatomic, strong) DeckCollectionViewController *deckCollectionVC;

@end

@implementation StudyViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    [self layoutNavigationBarItems];
    [self layoutSubviews];
}

- (void)layoutSubviews {
    self.draggableViewBackground = [[StudyDraggableViewBackground alloc] initWithFrame:self.view.bounds];
    self.draggableViewBackground.deck = self.deck;
    self.draggableViewBackground.session = self.session;
    self.draggableViewBackground.studyVC = self;
    [self.draggableViewBackground setCards:[self.deck.cards.set allObjects]];
    [self.draggableViewBackground setTopCardInDeck:[self.draggableViewBackground shuffleCards:self.draggableViewBackground.cards]];
    [self.draggableViewBackground loadCards];
    [self.view addSubview:self.draggableViewBackground];
}

- (void)layoutNavigationBarItems {
    NSString *string = [NSString stringWithFormat:@"Studying %@", self.deck.nameTag];
    self.navigationItem.title = string;

    UIImage *backIcon = [UIImage imageNamed:@"backbutton"];
    self.navigationItem.leftBarButtonItem = [UIBarButtonItem backButtonWithImage:backIcon target:self action:@selector(backButtonAction)];
    [self.navigationItem.leftBarButtonItem setTintColor:[UIColor customBlueColor]];

}

- (void)test {
    NSLog(@"Button");
}

- (void)backButtonAction {
    Session *session = [self.deck.sessions lastObject];
    [[DeckController sharedInstance] removeSession:session];
    [[DeckController sharedInstance] save];
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
