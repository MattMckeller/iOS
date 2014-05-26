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
@property (nonatomic, readwrite) NSInteger numberOfMatches;
@property (nonatomic, readwrite) NSMutableString *historyText;
/* @NSArray cardButtons
 Has to be strong, because even though the view has a strong pointer to every button individually
 nothing has a strong pointer to the array of them, so it would be constantly 0
*/
@property (strong, nonatomic) IBOutletCollection(UIButton) NSArray *cardButtons;
@property (weak, nonatomic) IBOutlet UILabel *scoreLabel;
@property (weak, nonatomic) IBOutlet UISegmentedControl *sliderVal;
@property (weak, nonatomic) IBOutlet UITextView *historyTextView;

//Private Methods
//-(Deck*) createDeck; Creates a PlayingCardDeck and returns it
//-(void) updateUI;
//-(NSString *)titleForCard
//-(UIImage *)backgroundImageForCard
//-(NSString*) newHistoryText

@end

@implementation ViewController


-(CardMatchingGame*) game{
    if(!_game) _game = [[CardMatchingGame alloc] initWithCardCount:[self.cardButtons count]
                                                         usingDeck:[self createDeck]
                                                 withAmountToMatch:[self sliderValue]];
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

-(NSMutableString*) historyText{
    if(!_historyText) _historyText = [[NSMutableString alloc] init];
    return _historyText;
}

- (IBAction)touchCardButton:(UIButton *)sender {
    int chosenButtonIndex = [self.cardButtons indexOfObject:sender]; //Tells us which card in the array it is
    [self.game chooseCardAtIndex:chosenButtonIndex];
    [self updateUI];
}

static const int SLIDER_LEFT_MATCH_NUMBER = 2;
static const int SLIDER_RIGHT_MATCH_NUMBER = 3;
- (IBAction)touchSliderButton:(UISegmentedControl *)sender {
    if(sender.selectedSegmentIndex == 0){
        NSLog(@"Slider left");
        self.numberOfMatches = SLIDER_LEFT_MATCH_NUMBER;
        self.game.amountToMatch = SLIDER_LEFT_MATCH_NUMBER;
    }else{
        NSLog(@"Slider right");
        self.numberOfMatches = SLIDER_RIGHT_MATCH_NUMBER;
        self.game.amountToMatch = SLIDER_RIGHT_MATCH_NUMBER;
    }
}

-(NSUInteger) sliderValue{
    NSUInteger value = 0;
    if( self.sliderVal.selectedSegmentIndex == 0){ value = SLIDER_LEFT_MATCH_NUMBER; }
    else{ value = SLIDER_RIGHT_MATCH_NUMBER; }
    return value;
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
    
    self.historyTextView.text = [self newHistoryText];
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %d", self.game.score];
}

-(NSString *)titleForCard:(Card*) card{
    return card.isChosen ? card.contents : @"";
}

-(UIImage *)backgroundImageForCard:(Card *) card{
    return [UIImage imageNamed:card.isChosen ? @"cardFront" : @"cardBack"];
}

-(NSString*) newHistoryText{
    NSLog([self.game.history firstObject]);
    return [NSString stringWithFormat:@"%@ \n %@ ", [self.game.history firstObject], self.historyText];
}

@end
