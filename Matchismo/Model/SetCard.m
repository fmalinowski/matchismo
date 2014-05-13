//
//  SetCard.m
//  Matchismo
//
//  Created by Francois Malinowski on 05/05/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import "SetCard.h"

@implementation SetCard

static const int MAX_NUMBER     = 3;
static const int WIN_SCORE      = 12;
static const int LOST_SCORE     = -2;

+ (NSUInteger)maxNumber {
    return MAX_NUMBER;
}

+ (NSArray *)validSymbols {
    return @[@"▲",@"●",@"■"];
}

+ (NSArray *)validShadings {
    return @[@"solid", @"striped", @"open"];
}

+ (NSArray *)validColors {
    return @[@"red", @"green", @"purple"];
}


- (NSString *)contents {
    return nil;
}

- (void)setNumber:(NSUInteger)number {
    if (number <= MAX_NUMBER) {
        _number = number;
    }
}

- (void)setSymbol:(NSString *)symbol {
    if ([[SetCard validSymbols] containsObject:symbol]) {
        _symbol = symbol;
    }
}

- (void)setShading:(NSString *)shading {
    if ([[SetCard validShadings] containsObject:shading]) {
        _shading = shading;
    }
}

- (void)setColor:(NSString *)color {
    if ([[SetCard validColors] containsObject:color]) {
        _color = color;
    }
}


- (int)match:(NSArray *)otherCards {
    
    NSMutableArray *cards = [otherCards mutableCopy];
    [cards addObject:self];
    
    if (([self checkSameValuesForType:@"number" cards:cards]
            || [self checkDifferentValuesForType:@"number" cards:cards])
        && ([self checkSameValuesForType:@"symbol" cards:cards]
            || [self checkDifferentValuesForType:@"symbol" cards:cards])
        && ([self checkSameValuesForType:@"shading" cards:cards]
            || [self checkDifferentValuesForType:@"shading" cards:cards])
        && ([self checkSameValuesForType:@"color" cards:cards]
            || [self checkDifferentValuesForType:@"color" cards:cards])) {
            return WIN_SCORE;
        }
    else {
        return LOST_SCORE;
    }
}

- (BOOL)checkSameValuesForType:(NSString *)type cards:(NSArray *)cards {
    
    for (int i = 1; i < [cards count]; i++) {
        if ([(SetCard *)cards[0] valueForKey:type] != [(SetCard *)cards[i] valueForKey:type])
            return NO;
    }
    return YES;
}

- (BOOL)checkDifferentValuesForType:(NSString *)type cards:(NSArray *)cards {
    
    NSMutableDictionary *cardValues;
    
    cardValues = [[NSMutableDictionary alloc] init];
    
    for (int i = 0; i < [cards count]; i++) {
        id value = [(SetCard *)cards[i] valueForKey:type];
        if(cardValues[value])
            return NO;
        cardValues[value] = @"YES";
    }
    
    return YES;
}

@end
