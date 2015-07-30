//
//  StartViewController.h
//  Super Paddle
//
//  Created by Mike Aboody on 6/26/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <iAd/iAd.h>

@interface StartViewController : UIViewController <ADBannerViewDelegate>
{
    IBOutlet UISlider *scoreChoice;
    IBOutlet UILabel *scoreLabel;
    IBOutlet UIButton *startButton;
    IBOutlet UIButton *optionsButton;
    
    int currentScoreChoice;
    
}
-(IBAction)buttonAction:(id)sender;
-(IBAction) sliderMoved: (id) sender;
-(IBAction) optionsButtonAction: (id) sender;
@end
