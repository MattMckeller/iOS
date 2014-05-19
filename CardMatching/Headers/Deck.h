//
//  Deck.h
//  CardMatching
//
//  Created by Matt Mckeller on 5/5/14.
//  Copyright (c) 2014 Matthew Mckeller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"
@interface Deck : NSObject
-(void)addCard:(Card*)card atTop:(BOOL)atTop;
-(void)addCard:(Card *)card;
-(Card*)drawRandomCard;
@end
