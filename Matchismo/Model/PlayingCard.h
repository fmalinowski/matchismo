//
//  PlayingCard.h
//  Matchismo
//
//  Created by Francois Malinowski on 29/03/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import "Card.h"

@interface PlayingCard : Card

@property (strong,nonatomic) NSString *suit;
@property (nonatomic) NSUInteger rank;

+ (NSArray *)validSuits;
+ (NSUInteger)maxRank;

@end
