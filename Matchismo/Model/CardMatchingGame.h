//
//  CardMatchingGame.h
//  Matchismo
//
//  Created by Francois Malinowski on 14/04/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"
#import "Card.h"

@interface CardMatchingGame : NSObject

// designated initializer
- (instancetype)initWithCardCount:(NSUInteger)count
                        usingDeck:(Deck *)deck;
- (void)chooseCardAtIndex:(NSUInteger)index;
- (Card *)cardAtIndex:(NSUInteger)index;
@property (nonatomic, readonly) NSInteger score;
@property (nonatomic) NSInteger cardMatchMode;
@property (nonatomic, readonly) NSInteger lastPoints;
@property (nonatomic, readonly) NSMutableArray *lastAttemptedMatch; //of Card
@property (nonatomic, readonly) NSString *lastAction; // CHOSEN or MATCH_TRY or NOTHING
@property (nonatomic, readonly) Card* lastChosenCard;

@end
