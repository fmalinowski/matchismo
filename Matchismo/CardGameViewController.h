//
//  CardGameViewController.h
//  Matchismo
//
//  Created by Francois Malinowski on 07/05/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//
// Abstract class. Must implement methods as decribed below.

#import <UIKit/UIKit.h>
#import "CardMatchingGame.h"

@interface CardGameViewController : UIViewController

// protected
// for subclasses

@property (strong, nonatomic) CardMatchingGame *game;
@property (nonatomic) int cardMatchMode;
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *resultCardMatchLabel;

- (Deck *)createDeck;
- (void)updateUI;
- (void)resetUI;

- (IBAction)startNewGameButton:(UIButton *)sender;
- (IBAction)touchCardButton:(UIButton *)sender;
- (void)updateResultCardMatchLabel; // Abstract

- (NSAttributedString *)titleForCard:(Card *) card; // Abstract
- (UIImage *)backgroundImageForCard:(Card *)card; // Abstract

@end
