//
//  ViewController.m
//  CardMatching
//
//  Created by Matt Mckeller on 5/4/14.
//  Copyright (c) 2014 Matthew Mckeller. All rights reserved.
//

#import "ViewController.h"


@interface ViewController ()
@property (weak, nonatomic) IBOutlet UILabel *flipsLabel;
@property (strong,nonatomic) Deck *deck;
@property (nonatomic) int flipCount;
@end
@implementation ViewController

-(void) setFlipCount:(int)flipCount{
    _flipCount = flipCount;
    self.flipsLabel.text = [NSString stringWithFormat:@"Flips: %d", self.flipCount];
    NSLog(@"flipCount changed to %d", self.flipCount);
    
}

-(Deck*) deck{
    if(!_deck){
        _deck = [[PlayingCardDeck alloc] init];
        return _deck;
    }
    else{
        return _deck;
    }
}

- (IBAction)touchCardButton:(UIButton *)sender {
    if([sender.currentTitle length]){
        UIImage *cardImage = [UIImage imageNamed:@"cardBack"];
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        [sender setTitle:@"" forState:UIControlStateNormal];
    }else{
        UIImage *cardImage = [UIImage imageNamed:@"cardFront"];
        NSString *chosenContents = self.deck.drawRandomCard.contents;
        [sender setBackgroundImage:cardImage forState:UIControlStateNormal];
        [sender setTitle:chosenContents forState:UIControlStateNormal];
    }
    self.flipCount++;
    
}


@end
