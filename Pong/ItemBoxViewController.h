//
//  ItemBoxViewController.h
//  Super Paddle
//
//  Created by Mike Aboody on 10/19/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ItemBoxViewController : UIViewController
{
    IBOutlet UISwitch *wallSwitch;
    IBOutlet UISwitch *smallerSwitch;
    IBOutlet UISwitch *disableSwitch;
    IBOutlet UISwitch *fasterSwitch;
    IBOutlet UIButton *descriptionButtonOne;
    IBOutlet UIButton *descriptionButtonTwo;
    IBOutlet UIButton *descriptionButtonThree;
    IBOutlet UIButton *descriptionButtonFour;
    IBOutlet UIButton *button;
}
-(IBAction)wallDescription:(id)sender;
-(IBAction)smallerDescription:(id)sender;
-(IBAction)disableDescription:(id)sender;
-(IBAction)fasterDescription:(id)sender;
-(IBAction)save:(id)sender;

@end
