//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Francois Malinowski on 07/05/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import "CardGameViewController.h"
#import "Deck.h"

@interface CardGameViewController ()

@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (nonatomic) int threeCardMode;

@end


@implementation CardGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	self.cardMatchMode = 3;
}

- (IBAction)startNewGameButton:(UIButton *)sender {
    _game = [self createNewGame];
    [self resetUI];
}

- (CardMatchingGame *)createNewGame {
    CardMatchingGame *cardGame = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    cardGame.cardMatchMode = self.cardMatchMode;
    return cardGame;
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [self createNewGame];
    }
    
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (Deck *)createDeck {
    return [[Deck alloc] init];
}

- (void)updateUI {
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setAttributedTitle:[self titleForCard:card]
                              forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    
    [self updateResultCardMatchLabel];
}

- (void)resetUI {
    self.scoreLabel.text = @"Score: 0";
    self.resultCardMatchLabel.attributedText = [[NSAttributedString alloc] initWithString:@"The game didn't start yet!"];
}

- (NSAttributedString *)titleForCard:(Card *) card {
    return nil;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return nil;
}

- (void)updateResultCardMatchLabel {
}

@end

