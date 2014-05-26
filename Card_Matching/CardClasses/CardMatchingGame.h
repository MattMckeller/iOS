//
//  CardMatchingGame.h
//  CardMatching
//
//  Created by Matt Mckeller on 5/20/14.
//  Copyright (c) 2014 Matthew Mckeller. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "Deck.h"

@interface CardMatchingGame : NSObject

//Designated Initializer
-(instancetype)initWithCardCount:(NSUInteger)count usingDeck:(Deck*) deck withAmountToMatch:(NSUInteger)amount;

-(void)chooseCardAtIndex:(NSUInteger) index;
-(Card*)cardAtIndex:(NSUInteger) index;

//Read only as the user is not suppose to be able to change this
@property(nonatomic, readonly) NSInteger score;
@property(nonatomic, readwrite) NSUInteger amountToMatch;
@property(nonatomic, strong) NSMutableArray *history;
@end
