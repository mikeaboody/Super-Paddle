//
//  PauseViewController.h
//  Super Paddle
//
//  Created by Mike Aboody on 6/27/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AIViewController.h"

@interface PauseViewController : UIViewController
{
    IBOutlet UIButton *buttonOne;
    IBOutlet UIButton *buttonTwo;
    IBOutlet UIButton *buttonThree;
}

-(IBAction)quitAction:(id) sender;
-(IBAction)returnAction:(id)sender;
-(IBAction)restartAction:(id)sender;
@end
