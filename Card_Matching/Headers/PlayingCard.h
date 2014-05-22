//
//  PlayingCard.h
//  CardMatching
//
//  Created by Matt Mckeller on 5/5/14.
//  Copyright (c) 2014 Matthew Mckeller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Card.h"

@interface PlayingCard : Card

@property(strong,nonatomic) NSString* suit;
@property(nonatomic) NSUInteger rank;

+(NSUInteger) isValidSuit:(NSString*) suit;
+(NSArray*) validSuits;
+(NSUInteger)maxRank;
@end
