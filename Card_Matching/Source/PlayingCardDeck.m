//
//  PlayingCardDeck.m
//  CardMatching
//
//  Created by Matt Mckeller on 5/5/14.
//  Copyright (c) 2014 Matthew Mckeller. All rights reserved.
//

#import "PlayingCardDeck.h"
#import "PlayingCard.h"

@implementation PlayingCardDeck
//Instancetype returns an object that has the same type as the object you sent the message to, it is only used in xcode and ignored in compiler
-(instancetype) init
{
    //Just a common custom, making sure the super class has been initilized first
    self = [super init];
    //The idea behind self = super init is to return nil if you cannot initalize for some reason
    if(self){
        for( NSString *suit in [PlayingCard validSuits]){
            for(NSUInteger rank=1; rank<=[PlayingCard maxRank]; rank++){
                PlayingCard *card = [[PlayingCard alloc] init ];
                card.rank = rank;
                card.suit = suit;
                [self addCard:card];
            }
        }
    }
    
    return self;
}
@end
