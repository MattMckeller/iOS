//
//  PlayingCard.m
//  CardMatching
//
//  Created by Matt Mckeller on 5/5/14.
//  Copyright (c) 2014 Matthew Mckeller. All rights reserved.
//

#import "PlayingCard.h"

@implementation PlayingCard

-(int) match:(NSArray *)otherCards{
    int score = 0;
    
    if([otherCards count] == 1){
        PlayingCard *otherCard = [otherCards firstObject]; //firstObject doesnt crash if array is empty
        if (self.rank == otherCard.rank){
            score = 4;
        }else if( [self.suit  isEqualToString:otherCard.suit] ){
            score = 1;
        }
    }
    
    return score;
}

//Contents function inheirited from parent class
-(NSString*) contents{
    NSArray *rankStrings = [PlayingCard rankStrings];
    return [rankStrings[self.rank] stringByAppendingString:self.suit];
}

//Did both set and get for suit, so including synthesize
@synthesize suit = _suit;

//Overloaded set function for suit
-(void) setSuit:(NSString*) suit{
    if([PlayingCard isValidSuit:suit]){
        _suit=suit;
    }
}

//Overloaded get operator for suit
-(NSString*) suit{
    if(!_suit){
        _suit = [[NSString alloc] init];
        _suit = @"?";
    }
    return _suit;
}

//Overloaded set operator for rank
-(void)setRank:(NSUInteger)rank{
    if( rank<= [PlayingCard maxRank]){
        _rank = rank;
    }
}

+(NSArray*) validSuits{
    return @[@"♣", @"♠", @"♦", @"♥"];
}

//Class methods start with +, instance methods start with -
+(NSUInteger) isValidSuit:(NSString *)suit{
    NSUInteger validity = 0;
    if([@[@"♣", @"♠", @"♦", @"♥"] containsObject:suit]){
        validity = 1;
    }
    return validity;
}

+(NSArray *)rankStrings{
    return( @[@"?", @"A", @"2", @"3", @"4", @"5", @"6", @"7", @"8",@"9", @"10", @"J", @"Q", @"K"] );
}

+(NSUInteger)maxRank {
    return[[self rankStrings] count]-1;
}

@end
