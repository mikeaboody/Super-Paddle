//
//  ViewController.h
//  Super Paddle
//
//  Created by Mike Aboody on 6/25/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Ball.h"
#import "Paddle.h"
#import "EndGameViewController.h"

@interface AIViewController : UIViewController
{
    NSTimer *timer;
    NSTimer *delayTimer;
    NSTimer *computerTimer;
    NSTimer *addingTimer;
    UIImageView *paddleLeft;
    UIImageView *paddleRight;
    UIView *ball;
    UIImageView *line;
    UIImageView *wallImage;
    UIButton *pauseButton;
    UILabel *playerLabel;
    UILabel *computerLabel;
    UILabel *touchScreenLabel;
    NSMutableArray *playerSubViews;
    NSMutableArray *computerSubViews;
    NSMutableArray *playerImageViews;
    NSMutableArray *computerImageViews;
    NSMutableArray *itemsOnScreen;
    NSMutableArray *playerTimers;
    NSMutableArray *computerTimers;
    Ball *ballObj;
    Paddle *paddleLeftObj;
    Paddle *paddleRightObj;
    CGPoint resetPoint;
    int playerScore;
    int computerScore;
    int lastHit;
    int playerCounts[3];
    int computerCounts[3];
    int playerColors[3];
    int computerColors[3];
    int playerColorIncrement[3];
    int computerColorIncrement[3];
    int computerIntersectPoint;
    double playerBallMultiplier;
    double computerBallMultiplier;
    bool playerPUUsed[4];
    bool computerPUUsed[4];
}

-(void) timerUpdate;
-(void) delay;
-(void) moveImage: (UIImageView*) image : (double) X_Amount : (double) Y_Amount;
-(void) stopTimer;
-(void) startTimer;
-(void) startComputerTimer;
-(void) stopComputerTimer;
+(void) changeStart: (int) score;
+(void) changeOptions: (int) amountOfItemsArg : (double) itemDensityArg : (bool) singlePlayerArg :(int) difficultyArg;
-(void) pause:(id)sender;
-(void) addItemsToScreen;
-(void) AIMove;
-(int) randomInt: (int) low : (int) high;
-(double) calculateIntersectPoint;
-(void) checkWin;
-(bool) imageNameCheck: (UIImageView*) imageView : (NSString*) imageName;
-(void) StopAction: (NSTimer*) timer;
-(void) resetPU: (int) PU : (int) player;
-(void) AIChoosePU: (int) PU;
+(void) setItemList: (NSMutableArray*) array;

@end

