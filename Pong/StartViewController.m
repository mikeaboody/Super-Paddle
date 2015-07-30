//
//  StartViewController.m
//  Super Paddle
//
//  Created by Mike Aboody on 6/26/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "StartViewController.h"
#import "AIViewController.h"

@interface StartViewController ()
{
    ADBannerView *_bannerView;
}
@end

@implementation StartViewController

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
    [self.view setBackgroundColor:[UIColor blackColor]];
    if(self.view.bounds.size.height == 568) {
        startButton.bounds = CGRectMake(startButton.bounds.origin.x+50, startButton.bounds.origin.y, 50, 50);
        optionsButton.center = CGPointMake(optionsButton.center.x + 50, optionsButton.center.y);
    }
    
    scoreChoice.value = 0.5;
    currentScoreChoice = 10;
    startButton.layer.cornerRadius = 10;
    optionsButton.layer.cornerRadius = 10;
    
    [self.view addSubview:_bannerView];
    
	// Do any additional setup after loading the view.
}
- (IBAction) buttonAction: (id) sender
{
    [AIViewController changeStart: currentScoreChoice];
    [self performSegueWithIdentifier:@"startToAI" sender:sender];
}

-(IBAction) optionsButtonAction: (id) sender
{
    [self performSegueWithIdentifier:@"startToOptions" sender:sender];
}

-(IBAction) sliderMoved:(id)sender
{
    currentScoreChoice = (int) (10 * scoreChoice.value) + 5;
    scoreLabel.text = [[NSString alloc] initWithFormat: @"%d", currentScoreChoice];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
