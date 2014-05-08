//
//  CardMatchingGame.m
//  Matchismo
//
//  Created by Francois Malinowski on 14/04/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property (nonatomic, readwrite) NSInteger score;
@property (nonatomic, strong) NSMutableArray *cards; // of Card
@property (nonatomic, readwrite) NSInteger lastPoints;
@property (nonatomic, readwrite) NSMutableArray *lastAttemptedMatch; // of Card
@property (nonatomic, readwrite) NSString *lastAction;
@property (nonatomic, readwrite) Card* lastChosenCard;
@end

@implementation CardMatchingGame

static const int MISMATCH_PENALTY = 2;
static const int MATCH_BONUS = 4;
static const int COST_TO_CHOOSE = 1;

- (NSMutableArray *)cards {
    if (!_cards) {
        _cards = [[NSMutableArray alloc] init];
    }
    return _cards;
}

- (instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck *)deck {
    self = [super init];
    
    if (self) {
        for (int i = 0; i < count; i++) {
            Card *card = [deck drawRandomCard];
            if(card) {
                [self.cards addObject:card];
            }
            else {
                self = nil;
                break;
            }
            
        }
    }
    return self;
}

- (void)chooseCardAtIndex:(NSUInteger)index {
    Card *card = [self cardAtIndex:index];
    
    self.lastAction = @"NOTHING";
    
    if(!card.isMatched) {
        if(card.isChosen) {
            card.chosen = NO;
        }
        else {
            [self chooseCardNotChosen:card];
        }
    }
}

- (void)chooseCardNotChosen:(Card *)card {
    
    NSMutableArray *chosenCards; // of Card
    chosenCards = [[NSMutableArray alloc] init];
    
    self.lastAction = @"CHOSEN";
    self.lastChosenCard = card;
    
    for (Card *otherCard in self.cards) {
        
        if (otherCard.isChosen && !otherCard.isMatched) {
            [chosenCards addObject:otherCard];
            
            if ([chosenCards count] == (self.cardMatchMode - 1)) {
                [self tryAMatch:card chosenCards:chosenCards];
                self.lastAction = @"MATCH_TRY";
                break;
            }
        }
    }
    self.score -= COST_TO_CHOOSE;
    card.chosen = YES;
}

- (Card *)cardAtIndex:(NSUInteger)index {
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

- (void)tryAMatch:(Card *)card chosenCards:(NSMutableArray *)chosenCards {
    int matchScore = [card match:chosenCards];
    
    if(matchScore) {
        [self matchedCard:card matchedCards:chosenCards matchScore:matchScore];
    }
    else {
        [self nonMatchedCards:chosenCards];
    }
    
    [self saveAttemptedMatch:card otherCards:chosenCards];
}

- (void)matchedCard:(Card *)card matchedCards:(NSMutableArray *)matchedCards matchScore:(int)matchScore {
    
    int increased_score = matchScore * MATCH_BONUS;
    self.score += increased_score;
    self.lastPoints = increased_score;
    
    for(Card *otherCard in matchedCards) {
        otherCard.matched = YES;
    }
    card.matched = YES;
}

- (void)nonMatchedCards:(NSMutableArray *)nonMatchedCards {
    
    self.score -= MISMATCH_PENALTY;
    self.lastPoints = -MISMATCH_PENALTY;
    
    for(Card *otherCard in nonMatchedCards) {
        otherCard.chosen = NO;
    }
}

- (void)saveAttemptedMatch:card otherCards:otherCards {
    self.lastAttemptedMatch = [[NSMutableArray alloc] init];
    
    [self.lastAttemptedMatch addObject:card];
    for (Card *otherCard in otherCards) {
        [self.lastAttemptedMatch addObject:otherCard];
    }
}

@end
