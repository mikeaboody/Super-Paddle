//
//  EndGameViewController.h
//  Super Paddle
//
//  Created by Mike Aboody on 6/27/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EndGameViewController : UIViewController
{
    IBOutlet UILabel *winLabel;
    IBOutlet UIButton *buttonOne;
    IBOutlet UIButton *buttonTwo;
    IBOutlet UILabel *secondWinLabel;
}
-(IBAction)replayAction: (id) sender;
-(IBAction)quitAction:(id)sender;
+(void) setWinner: (int) winner : (bool) singleArg;
@end
