//
//  CardGameViewController.m
//  Matchismo
//
//  Created by Francois Malinowski on 28/03/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import "CardGameViewController.h"
#import "PlayingCardDeck.h"
#import "CardMatchingGame.h"

@interface CardGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *resultCardMatchLabel;
@property (strong, nonatomic) Deck *deck;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UILabel *matchModeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *cardModeSwitch;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) int threeCardMode;
@end

@implementation CardGameViewController

- (IBAction)matchModeSwitch:(UISwitch *)sender {
    if ([sender isOn]) {
        self.matchModeLabel.text = @"3-card-match mode";
        self.game.cardMatchMode = 3;
    }
    else {
        self.matchModeLabel.text = @"2-card-match mode";
        self.game.cardMatchMode = 2;
    }
}

- (IBAction)startNewGameButton:(UIButton *)sender {
    _game = [self createNewGame];
    self.scoreLabel.text = @"Score: 0";
    [self resetUI];
    self.cardModeSwitch.enabled = YES;
}

- (CardMatchingGame *)createNewGame {
    CardMatchingGame *cardGame = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count] usingDeck:[self createDeck]];
    cardGame.cardMatchMode = [self.cardModeSwitch isOn] ? 3 : 2;
    return cardGame;
}

- (CardMatchingGame *)game {
    if (!_game) {
        _game = [self createNewGame];
    }
    
    return _game;
}

- (IBAction)touchCardButton:(UIButton *)sender {

    self.cardModeSwitch.enabled = NO;
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender];
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void)updateUI {
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card] forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
    }
    
    [self updateResultCardMatchLabel];
}

- (void)resetUI {
    for(UIButton *cardButton in self.cardButtons) {
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
}

- (NSString *)titleForCard:(Card *) card {
    return card.isChosen ? card.contents : @"";
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (void)updateResultCardMatchLabel {
    
    NSString *str;
    
    if ([self.game.lastAction isEqualToString:@"NOTHING"]) {
        self.resultCardMatchLabel.text = @"";
        NSLog(@"No action");
    }
    else if ([self.game.lastAction isEqualToString:@"CHOSEN"]) {
        self.resultCardMatchLabel.text = [NSString stringWithFormat:@"%@ ", self.game.lastChosenCard.contents];
        NSLog(@"Chose a card: %@", self.game.lastChosenCard.contents);
    }
    else {
        if (self.game.lastPoints > 0) {
            str = [NSString stringWithFormat:@"Matched %@ for %d points", self.game.lastAttemptedMatch, self.game.lastPoints];
            NSLog(@"Matched: %@", self.game.lastAttemptedMatch);
        }
        else {
            str = [NSString stringWithFormat:@"%@ don't match! %d point penalty!", self.game.lastAttemptedMatch, -self.game.lastPoints];
            NSLog(@"Mismatched: %@", self.game.lastAttemptedMatch);
        
        }
        self.resultCardMatchLabel.text = str;
    }
}

@end
