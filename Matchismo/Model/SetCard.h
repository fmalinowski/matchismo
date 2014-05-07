//
//  SetCard.h
//  Matchismo
//
//  Created by Francois Malinowski on 05/05/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import "Card.h"

@interface SetCard : Card

@property (nonatomic) NSUInteger number;
@property (strong,nonatomic) NSString *symbol;
@property (strong,nonatomic) NSString *shading;
@property (strong,nonatomic) NSString *color;

//@property (strong,nonatomic) NSString *suit;
//@property (nonatomic) NSUInteger rank;

+ (NSUInteger)maxNumber;
+ (NSArray *)validSymbols;
+ (NSArray *)validShadings;
+ (NSArray *)validColors;

//+ (NSArray *)validSuits;
//+ (NSUInteger)maxRank;


@end
