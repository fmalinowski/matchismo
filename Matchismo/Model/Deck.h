//
//  Deck.h
//  Matchismo
//
//  Created by Francois Malinowski on 30/03/2014.
//  Copyright (c) 2014 Francois Malinowski. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface Deck : NSObject

- (void)addCard:(Card *)card atTop:(BOOL)atTop;
- (void)addCard:(Card *)card;

- (Card *)drawRandomCard;

@end
