//
//  CardMatchingGameViewController.m
//  Matchismo
//
//  Created by Francois Malinowski on 28/03/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import "CardMatchingGameViewController.h"
#import "PlayingCardDeck.h"

@interface CardMatchingGameViewController ()
@property (weak, nonatomic) IBOutlet UILabel *matchModeLabel;
@property (weak, nonatomic) IBOutlet UISwitch *cardModeSwitch;
@end

@implementation CardMatchingGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.cardMatchMode = 2;
}

//SURE DONE
- (IBAction)matchModeSwitch:(UISwitch *)sender {
    if ([sender isOn]) {
        self.matchModeLabel.text = @"3-card match";
        self.game.cardMatchMode = 3;
        self.cardMatchMode = 3;
    }
    else {
        self.matchModeLabel.text = @"2-card match";
        self.game.cardMatchMode = 2;
        self.cardMatchMode = 2;
    }
}

- (IBAction)startNewGameButton:(UIButton *)sender {
    [super startNewGameButton:sender];
    self.cardModeSwitch.enabled = YES;
}

//SURE DONE
- (IBAction)touchCardButton:(UIButton *)sender {
    
    [super touchCardButton:sender];
    self.cardModeSwitch.enabled = NO;
}

//SURE DONE
- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void)resetUI {
    [super resetUI];
    
    for(UIButton *cardButton in self.cardButtons) {
        [cardButton setTitle:@"" forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
}

//SURE DONE?
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
        NSString *lastAttemptedMatchString = [self generateLastAttemptedMatchString:self.game.lastAttemptedMatch];
        
        if (self.game.lastPoints > 0) {
            str = [NSString stringWithFormat:@"Matched %@ for %d points", lastAttemptedMatchString, self.game.lastPoints];
            NSLog(@"Matched: %@", lastAttemptedMatchString);
        }
        else {
            str = [NSString stringWithFormat:@"%@ don't match! %d point penalty!", lastAttemptedMatchString, -self.game.lastPoints];
            NSLog(@"Mismatched: %@", lastAttemptedMatchString);
            
        }
        self.resultCardMatchLabel.text = str;
    }
}

- (NSString *)generateLastAttemptedMatchString:(NSArray *)cards {
    
    NSMutableString *cardsString = [[NSMutableString alloc] init];
    
    for (Card *card in cards) {
        [cardsString appendFormat:@"%@ ", [(Card *)card contents]];
    }
    
    return cardsString;
}

- (NSAttributedString *)titleForCard:(Card *) card {
    NSString *content;
    NSAttributedString *string;
    NSDictionary *attributes;
    
    content = card.isChosen ? card.contents : @"";
    attributes = @{NSForegroundColorAttributeName:
                       [self cardContentColor:card]};
    
    string = [[NSAttributedString alloc]
               initWithString:content
              attributes:attributes];
    
    return string;
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (UIColor *)cardContentColor:(Card *)card {
    if (([card.contents rangeOfString:@"♠︎"].location != NSNotFound) &&
        ([card.contents rangeOfString:@"♣︎"].location != NSNotFound)) {
        return [UIColor blackColor];
    }
    else {
        return [UIColor redColor];
    }
}

@end
