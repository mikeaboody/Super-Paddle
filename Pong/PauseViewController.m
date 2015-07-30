//
//  PauseViewController.m
//  Super Paddle
//
//  Created by Mike Aboody on 6/27/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "PauseViewController.h"
#import "AIViewController.h"

@interface PauseViewController ()

@end

@implementation PauseViewController

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
    buttonThree.layer.cornerRadius = 10;
    [self.view setBackgroundColor:[UIColor blackColor]];
	// Do any additional setup after loading the view.
}
- (IBAction) returnAction: (id) sender
{
    [self dismissViewControllerAnimated:NO completion: nil];
}
- (IBAction) quitAction: (id) sender
{
    [self performSegueWithIdentifier:@"pauseToStart" sender:sender];
}

-(IBAction)restartAction:(id)sender
{
    [self performSegueWithIdentifier:@"pauseToGame" sender:sender];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
