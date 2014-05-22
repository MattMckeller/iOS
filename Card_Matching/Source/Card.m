//
//  Card.m
//  CardMatching
//
//  Created by Matt Mckeller on 5/17/14.
//  Copyright (c) 2014 Matthew Mckeller. All rights reserved.
//

#import "Card.h"
@interface Card()
//Private declarations
@end

@implementation Card

-(int)match:(NSArray *) otherCards{
    int score = 0;
    for(Card *card in otherCards)
    if([card.contents isEqualToString:self.contents]){
        score = 1;
    }
    return score;
}

-(BOOL) isChosen{
    return _chosen;
}

@end
