//
//  CardMatchingGame.m
//  CardMatching
//
//  Created by Matt Mckeller on 5/20/14.
//  Copyright (c) 2014 Matthew Mckeller. All rights reserved.
//

#import "CardMatchingGame.h"

@interface CardMatchingGame()
@property(nonatomic, readwrite) NSInteger score;
@property(nonatomic, readwrite) NSUInteger chosenCount;
@property(nonatomic, strong) NSMutableArray *cards;
@property(nonatomic, strong) NSString* historyString;
@property(nonatomic, strong) NSString* stringToAppend;
@end

@implementation CardMatchingGame

-(NSMutableArray*) cards{
    if(!_cards) _cards = [[NSMutableArray alloc] init];
    return _cards;
}

-(NSMutableArray*) history{
    if(!_history) _history = [[NSMutableArray alloc] init];
    return _history;
}

-(NSString*) historyString{
    if(!_historyString) _historyString = [[NSString alloc] init];
    return _historyString;
}

-(NSString*) stringToAppend{
    if(!_stringToAppend) _stringToAppend = [[NSString alloc] init];
    return _stringToAppend;
}

-(instancetype)initWithCardCount:(NSUInteger)count
                       usingDeck:(Deck *)deck
               withAmountToMatch:(NSUInteger)amount{
    self = [super init];
    if(self){
        for(int i = 0; i<count; i++){
            Card* card = [deck drawRandomCard];
            if(card){
                [self.cards addObject:card];
            }else{
                self = nil;
                break;
            }
        }
    }
    self.amountToMatch = amount;
    self.chosenCount = 0;
    return self;
}

static const int MISMATCH_PENALTY = 2;
static const int COST_TO_CHOOSE = 1;
static const int MATCH_BONUS = 4;
-(void)chooseCardAtIndex:(NSUInteger)index{
    Card *card = [self cardAtIndex:index];
  
    //[stringToAppend stringByAppendingFormat:@"The card chosen(%@) ", card.contents];
    //[historyString stringByAppendingString:stringToAppend];
    self.historyString = [NSString stringWithFormat:@"The card chosen(%@) ", card.contents];
    NSLog(@"At start: %@", self.historyString);
    if(!card.isMatched){
        self.chosenCount++;
        if(card.isChosen){
            //Flip card back over if the same card is picked twice
            card.chosen = NO;
            self.chosenCount -= 2;
            self.historyString = [NSString stringWithFormat:@"%@ was flipped down. Score -1 ", self.historyString];
        }else if(self.chosenCount==self.amountToMatch){
            NSMutableArray *otherCards = [[NSMutableArray alloc] init];
            // match against other card/cards
            self.historyString = [NSString stringWithFormat:@"%@ was compared with ", self.historyString];
            for(Card *otherCard in self.cards){
                if(otherCard.isChosen && !otherCard.isMatched){
                    self.chosenCount--;
                    [otherCards addObject:otherCard];
                    self.historyString = [NSString stringWithFormat:@"%@ %@,", self.historyString, otherCard.contents];
                }
                //amountToMatch-1 because the most recent card is not included
                if([otherCards count] == (self.amountToMatch-1)){
                    int matchScore = [card match:otherCards];
                    if(matchScore){
                        self.historyString = [NSString stringWithFormat:@"%@they matched. Score was increased by: %d.", self.historyString, matchScore*MATCH_BONUS];
                        self.score += matchScore * MATCH_BONUS;
                        card.matched = YES;
                        for(Card *matchSuccessCard in otherCards){
                            matchSuccessCard.matched = YES;
                        }
                        self.chosenCount = 0;
                    }else{
                        self.score -= MISMATCH_PENALTY;
                        self.historyString = [NSString stringWithFormat:@"%@ they didn't match. Score was decreased by: %d ", self.historyString, MISMATCH_PENALTY];
                        card.matched = NO;
                        for(Card *matchFailedCard in otherCards){
                            matchFailedCard.chosen = NO;
                            matchFailedCard.matched = NO;
                        }
                    }
                    break;
                }
            }
            self.historyString = [NSString stringWithFormat:@"%@ Score -1 for selection.", self.historyString];
            self.score -= COST_TO_CHOOSE;
            card.chosen = YES;
        }else{ //Chosen cards is not at the set amount to match yet
            self.historyString = [NSString stringWithFormat:@"%@was turned face up. ", self.historyString];
            card.chosen = YES;
        }
    }
    NSLog(@"At end: %@", self.historyString);
    [self.history insertObject:self.historyString atIndex:0];
}

-(Card*)cardAtIndex:(NSUInteger) index{
    return (index < [self.cards count]) ? self.cards[index] : nil;
}

-(instancetype)init{
    return nil;
}

@end