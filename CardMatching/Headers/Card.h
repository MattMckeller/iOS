//
//  Card.h
//  CardMatching
//
//  Created by Matt Mckeller on 5/17/14.
//  Copyright (c) 2014 Matthew Mckeller. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Card : NSObject

//Vars
@property (strong, nonatomic) NSString *contents;
@property (nonatomic, getter=isChosen) BOOL chosen;
@property (nonatomic, getter=isMatched) BOOL matched;

//Methods
-(int)match:(NSArray *) otherCards;
@end
