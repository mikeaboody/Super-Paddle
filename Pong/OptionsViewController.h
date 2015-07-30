//
//  OptionsViewController.h
//  Super Paddle
//
//  Created by Mike Aboody on 7/4/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AIViewController.h"
@interface OptionsViewController : UIViewController
{
    int amountOfItems;
    int itemDensity;
    double itemDensitySender;
    IBOutlet UILabel *amountOfItemsLabel;
    IBOutlet UIStepper *amountOfItemsStepper;
    IBOutlet UISlider *itemDensitySlider;
    IBOutlet UILabel *itemDensityLabel;
    IBOutlet UISwitch *itemSwitch;
    IBOutlet UISwitch *singlePlayerSwitch;
    IBOutlet UISegmentedControl *difficultyControl;
    IBOutlet UIButton *saveButton;
    IBOutlet UIButton *cancelButton;
    IBOutlet UIButton *itemboxButton;
}
-(IBAction)saveSelected:(id)sender;
-(IBAction)cancelSelected:(id)sender;
-(IBAction)stepperValueChanged: (id) sender;
-(IBAction)itemDensitySliderChanged:(id)sender;
-(IBAction)itemSwitchChanged:(id)sender;
-(IBAction)itemboxSelected:(id) sender;
+(void) loadOptions: (int) amountOfItemsArg : (double) itemDensityArg : (bool) singlePlayerArg :(int) itemDensitySenderArg : (double) itemDensitySliderValArg : (int) selectedIndexSegmentArg : (int) itemSwitchVal;
@end
