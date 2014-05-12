//
//  CardMatchingGameViewController.m
//  Matchismo
//
//  Created by Francois Malinowski on 28/03/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import "CardMatchingGameViewController.h"
#import "PlayingCardDeck.h"
#import "PlayingCard.h"

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

- (IBAction)touchCardButton:(UIButton *)sender {
    
    [super touchCardButton:sender];
    self.cardModeSwitch.enabled = NO;
}

- (Deck *)createDeck {
    return [[PlayingCardDeck alloc] init];
}

- (void)resetUI {
    [super resetUI];
    
    NSAttributedString *cardTitle = [[NSAttributedString alloc] initWithString:@""];
    
    for(UIButton *cardButton in self.cardButtons) {
        [cardButton setAttributedTitle:cardTitle forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardback"] forState:UIControlStateNormal];
        cardButton.enabled = YES;
    }
}

- (void)updateResultCardMatchLabel {
    
    NSString *str;
    NSMutableAttributedString *string;
    
    if ([self.game.lastAction isEqualToString:@"NOTHING"]) {
        self.resultCardMatchLabel.text = @"";
        
    }
    else if ([self.game.lastAction isEqualToString:@"CHOSEN"])
    {
        string = [self titleForCard:self.game.lastChosenCard];
        self.resultCardMatchLabel.attributedText = string;
    }
    else {
        NSString *pointString;
        NSMutableAttributedString *lastAttemptedMatchString;
        
        lastAttemptedMatchString =
        [self generateLastAttemptedMatchString:self.game.lastAttemptedMatch];
        
        if (self.game.lastPoints > 0) {
            pointString = [NSString stringWithFormat:@"for %d points", self.game.lastPoints];
            
            string = [[NSMutableAttributedString alloc] initWithString:@"Matched "];
            [string appendAttributedString:lastAttemptedMatchString];
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:pointString]];
        }
        else {
            pointString = [NSString stringWithFormat:@"don't match! %d point penalty!", self.game.lastPoints];
            
            string = lastAttemptedMatchString;
            [string appendAttributedString:[[NSAttributedString alloc] initWithString:pointString]];
        }
        
        self.resultCardMatchLabel.attributedText = string;
    }
}

- (NSAttributedString *)generateLastAttemptedMatchString:(NSArray *)cards {
    
    NSMutableAttributedString *string = [[NSMutableAttributedString alloc] initWithString:@""];
    
    for (Card *card in cards) {
        [string appendAttributedString:
         [self cardNameWithStyle:card]];
        [string appendAttributedString:
         [[NSAttributedString alloc] initWithString:@" "]];
    }
    
    return string;
}

- (NSAttributedString *)cardNameWithStyle:(Card *) card {
    NSString *content;
    NSAttributedString *string;
    NSMutableDictionary *attributes;
    
    attributes = [[NSMutableDictionary alloc] init];
    
    content = card.contents;
    [attributes setObject:[self cardContentColor:card]
                   forKey:NSForegroundColorAttributeName];
    
    string = [[NSAttributedString alloc]
              initWithString:content
              attributes:attributes];
    
    return string;

}

- (NSAttributedString *)titleForCard:(Card *) card {
    
    if (card.isChosen) {
        return [self cardNameWithStyle:card];
    }
    else {
        return [[NSAttributedString alloc] initWithString:@""];
    }
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isChosen ? @"cardfront" : @"cardback"];
}

- (UIColor *)cardContentColor:(Card *)card {
    if ([((PlayingCard *)card).suit isEqualToString:@"♣︎"] ||
        [((PlayingCard *)card).suit isEqualToString:@"♠︎"]) {
        return [UIColor blackColor];
    }
    else {
        return [UIColor redColor];
    }
}

@end
