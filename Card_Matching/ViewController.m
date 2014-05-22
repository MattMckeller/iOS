//
//  ViewController.m
//  CardMatching
//
//  Created by Matt Mckeller on 5/4/14.
//  Copyright (c) 2014 Matthew Mckeller. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()
@property (strong,nonatomic) Deck *deck;
@property (strong,nonatomic) CardMatchingGame *game;
/* @NSArray cardButtons
 Has to be strong, because even though the view has a strong pointer to every button individually
 nothing has a strong pointer to the array of them, so it would be constantly 0
*/
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;

//Private Methods
//-(Deck*) createDeck; Creates a PlayingCardDeck and returns it
//-(void) updateUI;
//-(NSString *)titleForCard
//-(UIImage *)backgroundImageForCard

@end

@implementation ViewController

-(CardMatchingGame*) game{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]];
    return _game;
}

-(Deck*) deck{
    if(!_deck){
        _deck = [self createDeck];
        return _deck;
    }
    else{
        return _deck;
    }
}

-(Deck*) createDeck{
    return [[PlayingCardDeck alloc] init];
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender]; //Tells us which card in the array it is
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

-(void)updateUI{
    for(UIButton *cardButton in self.cardButtons){
        int cardButtonIndex = [self.cardButtons indexOfObject:cardButton];
        Card *card = [self.game cardAtIndex:cardButtonIndex];
        [cardButton setTitle:[self titleForCard:card]
                    forState:UIControlStateNormal];
        [cardButton setBackgroundImage:[self backgroundImageForCard:card]
                              forState:UIControlStateNormal];
        cardButton.enabled = !card.isMatched;
    }
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

-(NSString *)titleForCard:(Card*) card{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *) card{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

@end
