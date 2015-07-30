//
//  OptionsViewController.m
//  Super Paddle
//
//  Created by Mike Aboody on 7/4/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "OptionsViewController.h"
#import "AIViewController.h"

@interface OptionsViewController ()

@end

@implementation OptionsViewController
static int amountOfItemsSTAT;
static int itemDensitySTAT;
static double itemDensitySenderSTAT;
static bool singlePlayerSwitchOnSTAT;
static double itemDensitySliderValSTAT;
static int selectedIndexSegmentSTAT;
static bool itemSwitchOnSTAT;

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
    itemboxButton.layer.cornerRadius = 4;
    saveButton.layer.cornerRadius = 4;
    cancelButton.layer.cornerRadius = 4;
    itemSwitch.on = itemSwitchOnSTAT;
    if (!itemSwitchOnSTAT) {
        amountOfItemsStepper.value = 0;
        amountOfItems = 0;
        amountOfItemsStepper.userInteractionEnabled = NO;
        amountOfItemsLabel.text = @"None";
        
        itemDensitySlider.value = 0.00;
        itemDensitySender = 0.00;
        itemDensityLabel.text = @"None";
        itemDensity = 0;
        itemDensitySlider.userInteractionEnabled = NO;
    } else {
        amountOfItems = amountOfItemsSTAT;
        itemDensity = itemDensitySTAT;
        itemDensitySender = itemDensitySenderSTAT;
        amountOfItemsStepper.minimumValue = 1;
        amountOfItemsStepper.maximumValue = 3;
        amountOfItemsStepper.value = amountOfItems;
        if (amountOfItems == 0) {
            amountOfItemsLabel.text = @"None";
        } else {
            amountOfItemsLabel.text = [NSString stringWithFormat:@"%d", amountOfItems];
        }
        
        itemDensitySlider.value = itemDensitySliderValSTAT;
        
        if (itemDensitySlider.value == 0) {
            itemDensity = 0;
        } else {
            itemDensity = (int) (4 * itemDensitySlider.value) + 1;
        }
        if (itemDensity == 1 || itemDensity == 0) {
            itemDensitySender = 3.00;
            itemDensityLabel.text = @"Very Low";
        } else if (itemDensity == 2) {
            itemDensitySender = 2.50;
            itemDensityLabel.text = @"Low";
        } else if (itemDensity == 3) {
            itemDensitySender = 2.00;
            itemDensityLabel.text = @"Medium";
        } else if (itemDensity == 4) {
            itemDensitySender = 1.50;
            itemDensityLabel.text = @"High";
        } else if (itemDensity == 5) {
            itemDensitySender = 1.00;
            itemDensityLabel.text = @"Very High";
        }
    }
    
    
    singlePlayerSwitch.on = singlePlayerSwitchOnSTAT;
    
    [difficultyControl setSelectedSegmentIndex:selectedIndexSegmentSTAT];
    
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(IBAction)saveSelected:(id)sender
{
    int difficulty = 0;
    if ([[difficultyControl titleForSegmentAtIndex:difficultyControl.selectedSegmentIndex] isEqualToString:@"Medium"]) {
        difficulty = 1;
    } else if ([[difficultyControl titleForSegmentAtIndex:difficultyControl.selectedSegmentIndex] isEqualToString:@"Hard"]){
        difficulty = 2;
    } else {
        difficulty = 0;
    }
    amountOfItemsSTAT = amountOfItems;
    itemDensitySTAT = itemDensity;
    itemDensitySenderSTAT = itemDensitySender;
    singlePlayerSwitchOnSTAT = singlePlayerSwitch.on;
    itemDensitySliderValSTAT = itemDensitySlider.value;
    selectedIndexSegmentSTAT = difficulty;
    itemSwitchOnSTAT = itemSwitch.on;
    [AIViewController changeOptions:amountOfItems:itemDensitySender:!singlePlayerSwitch.on: difficulty];
    [self dismissViewControllerAnimated:NO completion: nil];
}
-(IBAction)cancelSelected:(id)sender
{
    [self dismissViewControllerAnimated:NO completion: nil];
}

- (IBAction)stepperValueChanged:(id)sender
{
    amountOfItems = amountOfItemsStepper.value;
    if (amountOfItems == 0) {
        amountOfItemsLabel.text = @"None";
    } else {
        amountOfItemsLabel.text = [NSString stringWithFormat:@"%d", amountOfItems];
    }
}


-(IBAction)itemDensitySliderChanged:(id)sender
{
    if (itemDensitySlider.value == 0) {
        itemDensity = 0;
    } else {
       itemDensity = (int) (4 * itemDensitySlider.value) + 1; 
    }
    if (itemDensity == 1 || itemDensity == 0) {
        itemDensitySender = 3.00;
        itemDensityLabel.text = @"Very Low";
    } else if (itemDensity == 2) {
        itemDensitySender = 2.50;
        itemDensityLabel.text = @"Low";
    } else if (itemDensity == 3) {
        itemDensitySender = 2.00;
        itemDensityLabel.text = @"Medium";
    } else if (itemDensity == 4) {
        itemDensitySender = 1.50;
        itemDensityLabel.text = @"High";
    } else if (itemDensity == 5) {
        itemDensitySender = 1.00;
        itemDensityLabel.text = @"Very High";
    }
}
-(IBAction)itemSwitchChanged:(id)sender
{
    if(itemSwitch.on) {
        amountOfItemsStepper.value = 1;
        amountOfItems = 1;
        amountOfItemsStepper.userInteractionEnabled = YES;
        amountOfItemsLabel.text = @"1";
        
        itemDensitySlider.value = 0.5;
        itemDensitySender = 2.00;
        amountOfItemsStepper.minimumValue = 1;
        amountOfItemsStepper.maximumValue = 3;
        itemDensityLabel.text = @"Medium";
        itemDensity = 3;
        itemDensitySlider.userInteractionEnabled = YES;
    } else {
        amountOfItemsStepper.value = 0;
        amountOfItems = 0;
        amountOfItemsStepper.userInteractionEnabled = NO;
        amountOfItemsLabel.text = @"None";
        
        itemDensitySlider.value = 0.00;
        itemDensitySender = 0.00;
        itemDensityLabel.text = @"None";
        itemDensity = 0;
        itemDensitySlider.userInteractionEnabled = NO;
        
    }
}
-(IBAction)itemboxSelected:(id)sender
{
    [self performSegueWithIdentifier:@"optionsToItem" sender:sender];
}

+(void) loadOptions: (int) amountOfItemsArg : (double) itemDensityArg : (bool) singlePlayerArg :(int) itemDensitySenderArg : (double) itemDensitySliderValArg : (int) selectedIndexSegmentArg : (int) itemSwitchVal;
{
    amountOfItemsSTAT = amountOfItemsArg;
    itemDensitySTAT = itemDensityArg;
    singlePlayerSwitchOnSTAT = singlePlayerArg;
    itemDensitySenderSTAT = itemDensitySenderArg;
    itemDensitySliderValSTAT = itemDensitySliderValArg;
    selectedIndexSegmentSTAT = selectedIndexSegmentArg;
    itemSwitchOnSTAT = itemSwitchVal;
}

@end
