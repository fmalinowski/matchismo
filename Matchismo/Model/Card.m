//
//  Card.m
//  Matchismo
//
//  Created by Francois Malinowski on 29/03/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import "Card.h"

@implementation Card

- (int)match:(NSArray *)otherCards {
    int score = 0;
    for(Card *card in otherCards) {
        if ([self.contents isEqualToString:card.contents]) {
            score = 1;
        }
    }
    return score;
}

@end
