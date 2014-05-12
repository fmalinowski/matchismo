//
//  SetGameViewController.m
//  Matchismo
//
//  Created by Francois Malinowski on 05/05/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import "SetGameViewController.h"
#import "SetCardDeck.h"
#import "SetCard.h"

@interface SetGameViewController ()

@end

@implementation SetGameViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithPatternImage:[UIImage imageNamed:@"background"]];
    self.cardMatchMode = 3;
    
    self.game = [self createNewGame];
    [self resetUI];
}

- (Deck *)createDeck {
    return [[SetCardDeck alloc] init];
}

- (NSAttributedString *)cardNameWithStyle:(Card *) card {
    NSString *content;
    NSAttributedString *string;
    NSMutableDictionary *attributes;
    
    attributes = [[NSMutableDictionary alloc] init];
    
    content = [self cardContent:card];
    [attributes setObject:[self cardContentColor:card]
                   forKey:NSForegroundColorAttributeName];
    
    string = [[NSAttributedString alloc]
              initWithString:content
              attributes:attributes];
    
    return string;
    
}

- (NSAttributedString *)titleForCard:(Card *) card {
    
    if (card.isMatched) {
        return [[NSAttributedString alloc] initWithString:@""];
    }
    else {
        return [self cardNameWithStyle:card];
    }
}

- (UIImage *)backgroundImageForCard:(Card *)card {
    return [UIImage imageNamed:card.isMatched ? @"cardback" : @"cardfront"];
}

- (NSString *)cardContent:(SetCard *)card {
    NSMutableString *content;
    
    content = [[NSMutableString alloc] init];
    
    for (int i = 1; i <= card.number; i++) {
        [content appendString:card.symbol];
    }
    
    return content;
}

- (UIColor *)cardContentColor:(Card *)card {
    if ([((SetCard *)card).color isEqualToString:@"red"]) {
        return [UIColor redColor];
    }
    else if ([((SetCard *)card).color isEqualToString:@"green"]) {
        return [UIColor greenColor];
    }
    else {
        return [UIColor purpleColor];
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
         [[NSAttributedString alloc] initWithString:@"  "]];
    }
    
    return string;
}

- (void)resetUI {
    [super resetUI];
    
    for (UIButton *cardButton in self.cardButtons) {
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton
         setAttributedTitle:[self cardNameWithStyle:card]
         forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[UIImage imageNamed:@"cardfront"] forState:UIControlStateNormal];
        cardButton.enabled = true;
    }
}

@end
