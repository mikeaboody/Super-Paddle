//
//  EndGameViewController.m
//  Super Paddle
//
//  Created by Mike Aboody on 6/27/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "EndGameViewController.h"

@interface EndGameViewController ()

@end

@implementation EndGameViewController
static int winnerVal;
static bool singleSTAT;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    buttonOne.layer.cornerRadius = 10;
    buttonTwo.layer.cornerRadius = 10;
    [self.view setBackgroundColor:[UIColor blackColor]];
    if (singleSTAT) {
        if (winnerVal == 0) {
            winLabel.text = @"Computer";
            secondWinLabel.text = @"Wins!";
        } else if (winnerVal == 1) {
            winLabel.text = @"You";
            secondWinLabel.text = @"Win!";
        }
    } else {
        if (winnerVal == 0) {
            winLabel.text = @"Player Two";
            secondWinLabel.text = @"Wins!";
        } else if (winnerVal == 1) {
            winLabel.text = @"Player One";
            secondWinLabel.text = @"Wins!";
        }
    }
    
}

- (IBAction) replayAction: (id) sender
{
    [self performSegueWithIdentifier:@"endToGame" sender:sender];
}
- (IBAction) quitAction: (id) sender
{
    [self performSegueWithIdentifier:@"endToStart" sender:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
+(void) setWinner: (int) winner : (bool) singleArg
{
    winnerVal = winner;
    singleSTAT = singleArg;
}

@end
