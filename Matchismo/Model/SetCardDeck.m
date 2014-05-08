//
//  SetCardDeck.m
//  Matchismo
//
//  Created by Francois Malinowski on 06/05/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import "SetCardDeck.h"
#import "SetCard.h"

@implementation SetCardDeck

- (instancetype)init {
    self = [super init];
    
    if (self) {
        for (int nb = 1; nb <= [SetCard maxNumber]; nb++) {
            for (NSString *symbol in [SetCard validSymbols]) {
                for (NSString *shading in [SetCard validShadings]) {
                    for (NSString *color in [SetCard validColors]) {
                        
                        SetCard *card = [[SetCard alloc] init];
                        card.number     = nb;
                        card.symbol     = symbol;
                        card.shading    = shading;
                        card.color      = color;
                        [self addCard:card];
                    }
                }
            }
            
        }
    }
    
    return self;
}

@end
