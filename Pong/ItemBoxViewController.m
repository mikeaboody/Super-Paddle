//
//  ItemBoxViewController.m
//  Super Paddle
//
//  Created by Mike Aboody on 10/19/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "ItemBoxViewController.h"
#import "AIViewController.h"

@interface ItemBoxViewController ()

@end

@implementation ItemBoxViewController
static bool wallOffSTAT;
static bool smallerOffSTAT;
static bool disableOffSTAT;
static bool fasterOffSTAT;

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
    descriptionButtonOne.layer.cornerRadius = 8;
    descriptionButtonTwo.layer.cornerRadius = 8;
    descriptionButtonThree.layer.cornerRadius = 8;
    descriptionButtonFour.layer.cornerRadius = 8;
    button.layer.cornerRadius = 4;
    wallSwitch.on = !wallOffSTAT;
    smallerSwitch.on = !smallerOffSTAT;
    disableSwitch.on = !disableOffSTAT;
    fasterSwitch.on = !fasterOffSTAT;
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)save:(id)sender
{
    if (!wallSwitch.on && !smallerSwitch.on && !fasterSwitch.on && !disableSwitch.on) {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"You Must Select At Least One Item" message:@"At least one item must be sleected in the Item Box. If you would like to turn items off alltogether, turn the 'Items' option off in Options." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
        [alert show];
    } else {
        NSMutableArray *itemList = [[NSMutableArray alloc] init];
        if(wallSwitch.on) {
            [itemList addObject:@"WallPU.png"];
        }
        if (smallerSwitch.on) {
            [itemList addObject:@"SmallerPU.png"];
        }
        
        if (fasterSwitch.on) {
            [itemList addObject:@"FasterPU.png"];
        }
        if (disableSwitch.on) {
            [itemList addObject:@"DisablePU.png"];
        }
        [AIViewController setItemList:itemList];
        wallOffSTAT = !wallSwitch.on;
        smallerOffSTAT = !smallerSwitch.on;
        disableOffSTAT = !disableSwitch.on;
        fasterOffSTAT = !fasterSwitch.on;
        [self dismissViewControllerAnimated:NO completion: nil];
        
    }
    
    //if all are off, turn first one on
    //make alarm saying that they can't have no items
    //otherwise save and get out
}

-(IBAction)wallDescription:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Wall Item" message:@"Creates a wall that keeps the ball on your opponents side of the screen. You can only use this item when the ball is on your opponent's side." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
-(IBAction)smallerDescription:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Shrink Item" message:@"Shrinks your opponent's paddle. You may use multiple shrink items at a time." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
-(IBAction)disableDescription:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Disable Item" message:@"Disables your opponent's paddle from moving for a very brief period of time." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}
-(IBAction)fasterDescription:(id)sender
{
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Boost Item" message:@"Makes the ball go faster off of your paddle and normal speed off of your opponent's paddle. You may use multiple boost items at a time." delegate:self cancelButtonTitle:@"OK" otherButtonTitles:nil];
    [alert show];
}



@end
