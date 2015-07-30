//
//  ViewController.m
//  Super Paddle
//
//  Created by Mike Aboody on 6/25/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//
//support@raidenmx.com
//nick@raidenmx.com
//STOP SHAKING: CAST AND MAKE MOVE = 1
//568, 320
//[paddleLeft setImage:[UIImage imageNamed:@"bush.png"]];
//hi = paddleLeft.image == [UIImage imageNamed:@"paddle.png"];
//[imageView removeFromSuperview];
//COMBOS BAD: B AND E, A AND B
//SHAKING WITH WALL COMES FROM WHEN YOU HAVE A FIRE AND YOU FIRE IT AT A A WALL
#import "AIViewController.h"
#import "Ball.h"
#import "Paddle.h"
#import "EndGameViewController.h"

@interface AIViewController ()

@end

@implementation AIViewController
static int scoreLimit;
static bool singlePlayer;
static int amountOfItems;
static int difficulty;
static double itemDensity;
static NSMutableArray *itemList;
- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view setMultipleTouchEnabled:YES];
    int resetPointX;
    int lineX;
    int pauseButtonX;
    int paddleLeftX;
    int paddleRightX;
    int playerLabelX;
    int computerLabelX;
    int touchScreenLabelX;
    int seperationBetweenItemHolders;
    int playerSubViewsCoordinate;
    int playerSubViewsWidth;
    int actualSubViewsWidth;
    int otherItemFactor;
    double ballSpeedTemp;
    
    if(self.view.bounds.size.height == 568) {
        resetPointX = 292;
        lineX = 292; //284+8
        pauseButtonX = 293; //284+8
        paddleLeftX = 13;
        paddleRightX = 537;
        playerLabelX = 126;
        computerLabelX = 365;
        if (!singlePlayer) {
            computerLabelX = 335;
        }
        touchScreenLabelX = 62;
        seperationBetweenItemHolders = 50;
        playerSubViewsCoordinate = 4;
        playerSubViewsWidth = 52;
        actualSubViewsWidth = 60;
        otherItemFactor = 58;
        ballSpeedTemp = 4.0;
    } else {
        resetPointX = 248;
        lineX = 248; //240+8
        pauseButtonX = 248; //240+8
        paddleLeftX = 13;
        paddleRightX = 440;
        playerLabelX = 90;
        computerLabelX = 300;
        if (!singlePlayer) {
            computerLabelX = 290;
        }
        touchScreenLabelX = 30;
        seperationBetweenItemHolders = 40;
        playerSubViewsCoordinate = 2;
        playerSubViewsWidth = 36;
        actualSubViewsWidth = 40;
        otherItemFactor = 40;
        ballSpeedTemp = 3.5;
    }
    
    [self.view setBackgroundColor: [UIColor blackColor]];
    resetPoint = CGPointMake(resetPointX,125);
    
    line = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"Line.png"]];
    line.center = CGPointMake(lineX, 160);
    line.bounds = CGRectMake(line.bounds.origin.x, line.bounds.origin.y, 26, 320);
    
    wallImage = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"wall.png"]];
    wallImage.center = CGPointMake(lineX, 160);
    wallImage.bounds = CGRectMake(wallImage.bounds.origin.x, wallImage.bounds.origin.y, 6, 320);
    wallImage.hidden = YES;
    
    
    pauseButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    [pauseButton addTarget:self action:@selector(pause:) forControlEvents:UIControlEventTouchUpInside];
    pauseButton.center = CGPointMake(pauseButtonX, 32);
    [pauseButton.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:20.0]];

    pauseButton.layer.cornerRadius = 4;
    pauseButton.bounds = CGRectMake(pauseButton.bounds.origin.x, pauseButton.bounds.origin.y, 26, 34);
    
    
    
    [pauseButton setTitle:@"II" forState:UIControlStateNormal];
    [pauseButton setBackgroundColor:[UIColor whiteColor]];
    paddleLeft = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"paddle.png"]];
    paddleLeft.center = CGPointMake(paddleLeftX, resetPoint.y);
    paddleLeft.bounds = CGRectMake(paddleLeft.bounds.origin.x, paddleLeft.bounds.origin.y, 18, 84);
    paddleRight = [[UIImageView alloc] initWithImage: [UIImage imageNamed:@"paddle.png"]];
    paddleRight.center = CGPointMake(paddleRightX, resetPoint.y);
    paddleRight.bounds = CGRectMake(paddleRight.bounds.origin.x, paddleRight.bounds.origin.y, 18, 84);
    
    ball = [[UIView alloc] init];
    ball.center = resetPoint;
    ball.bounds = CGRectMake(ball.bounds.origin.x, ball.bounds.origin.y, 15, 15);
    ball.backgroundColor = [UIColor whiteColor];
    
    playerLabel = [[UILabel alloc] initWithFrame: CGRectMake(playerLabelX, 12, 130, 20)];
    playerLabel.font = [UIFont fontWithName:@"Superclarendon-Light" size:17];
    playerLabel.backgroundColor = [UIColor clearColor];
    playerLabel.textAlignment = NSTextAlignmentCenter;
    playerLabel.textColor=[UIColor whiteColor];
    if (singlePlayer) {
        playerLabel.text = @"You: 0";
    } else {
        playerLabel.text = @"Player One: 0";
    }
    
    
    
    computerLabel = [[UILabel alloc] initWithFrame: CGRectMake(computerLabelX, 12, 130, 20)];
    computerLabel.font = [UIFont fontWithName:@"Superclarendon-Light" size:17];
    computerLabel.backgroundColor = [UIColor clearColor];
    computerLabel.textAlignment = NSTextAlignmentCenter;
    computerLabel.textColor=[UIColor whiteColor];
    if (singlePlayer) {
        computerLabel.text = @"Computer: 0";
    } else {
        computerLabel.text = @"Player Two: 0";
    }
    
    
    touchScreenLabel = [[UILabel alloc] initWithFrame: CGRectMake(touchScreenLabelX, 120, 438, 52)];
    touchScreenLabel.font = [UIFont fontWithName:@"Superclarendon-Bold" size:24];
    touchScreenLabel.backgroundColor = [UIColor clearColor];
    touchScreenLabel.textAlignment = NSTextAlignmentCenter;
    touchScreenLabel.textColor=[UIColor whiteColor];
    touchScreenLabel.text = @"Touch Screen to Start";
    
    playerSubViews = [[NSMutableArray alloc] init];
    computerSubViews = [[NSMutableArray alloc] init];
    playerImageViews = [[NSMutableArray alloc] init];
    computerImageViews = [[NSMutableArray alloc] init];
    playerTimers = [[NSMutableArray alloc] init];
    computerTimers = [[NSMutableArray alloc] init];
    itemsOnScreen = [[NSMutableArray alloc] init];
    for (int i = 1; i <= amountOfItems; i++) {
        [playerSubViews addObject:[[UIView alloc] initWithFrame:CGRectMake(resetPointX - i * (seperationBetweenItemHolders + 20), 255, actualSubViewsWidth, actualSubViewsWidth)]];
        [computerSubViews addObject:[[UIView alloc] initWithFrame:CGRectMake(resetPointX - otherItemFactor + i * (seperationBetweenItemHolders + 20), 255, actualSubViewsWidth, actualSubViewsWidth)]]; //NEED
        [playerImageViews addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blanksquare.png"]]];
        [computerImageViews addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:@"blanksquare.png"]]];
        [playerTimers addObject:[NSNull null]];
        [computerTimers addObject:[NSNull null]];
        //58
    }
    [self.view addSubview: line];
    [self.view addSubview: wallImage];
    [self.view addSubview: pauseButton];
    [self.view addSubview: paddleLeft];
    [self.view addSubview: paddleRight];
    [self.view addSubview: ball];
    [self.view addSubview:playerLabel];
    [self.view addSubview:computerLabel];
    [self.view addSubview:touchScreenLabel];
    for (int i = 0; i < amountOfItems; i++) {
        UIView *tempPlayerSubView = (UIView *) [playerSubViews objectAtIndex:i];
        UIView *tempComputerSubView = (UIView *) [computerSubViews objectAtIndex:i];
        tempPlayerSubView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        tempComputerSubView.backgroundColor = [UIColor colorWithRed:1 green:1 blue:1 alpha:1];
        
        UIImageView *tempPlayerImageView = (UIImageView *) [playerImageViews objectAtIndex:i];
        UIImageView *tempComputerImageView = (UIImageView *) [computerImageViews objectAtIndex:i];
        tempPlayerImageView.frame = CGRectMake(playerSubViewsCoordinate,playerSubViewsCoordinate,playerSubViewsWidth,playerSubViewsWidth);
        tempComputerImageView.frame = CGRectMake(playerSubViewsCoordinate,playerSubViewsCoordinate,playerSubViewsWidth,playerSubViewsWidth);
        
        [tempPlayerSubView addSubview:[playerImageViews objectAtIndex:i]];
        [tempComputerSubView addSubview:[computerImageViews objectAtIndex:i]];
        [self.view addSubview: (UIView *) [playerSubViews objectAtIndex:i]];
        [self.view addSubview:(UIView *) [computerSubViews objectAtIndex:i]];
    }
    
    
    for (int i = 0; i < 3; i++) {
        playerColorIncrement[i] = 1;
        computerColorIncrement[i] = 1;
        playerColors[i] = 255;
        computerColors[i] = 255;
    }
    
    playerScore = 0;
    timer = nil;
    addingTimer = nil;
    computerTimer = nil;
    computerScore = 0;
    playerBallMultiplier = 1.0;
    computerBallMultiplier = 1.0;
    lastHit = -1;
    ballObj = [[Ball alloc] init];
    ballObj.v_x = ballSpeedTemp;
    paddleLeftObj = [[Paddle alloc] init];
    paddleRightObj = [[Paddle alloc] init];
}
-(void) viewDidAppear:(BOOL)animated
{
    touchScreenLabel.hidden = NO;
    
}
-(void) startTimer
{
    timer = [NSTimer scheduledTimerWithTimeInterval:.005 target:self selector:@selector(timerUpdate) userInfo:nil repeats: YES];
    if (itemDensity != 0) {
        addingTimer = [NSTimer scheduledTimerWithTimeInterval:itemDensity target:self selector:@selector(addItemsToScreen) userInfo:nil repeats: YES];
    }
    
}

-(void) stopTimer
{
    [timer invalidate];
    timer = nil;
    if (itemDensity != 0) {
        [addingTimer invalidate];
        addingTimer = nil;
    }
    
}

-(void) startComputerTimer
{
    double timeInterval = 0;
    if (difficulty == 0) {
        timeInterval = .003;
    } else if (difficulty == 1) {
        timeInterval = .002;
    } else {
        timeInterval = .002;
    }
    computerTimer = [NSTimer scheduledTimerWithTimeInterval:timeInterval target:self selector:@selector(AIMove) userInfo:nil repeats: YES];
}

-(void) stopComputerTimer
{
    [computerTimer invalidate];
    computerTimer = nil;
}

-(void) AIChoosePU: (int) PU
{
 
    for (int j = 0; j < [computerSubViews count]; j++) {
        UIImageView *tempImageView = [computerImageViews objectAtIndex:j];
        NSMutableArray *tempArray = [[NSMutableArray alloc] init];
        if (PU == 0 && [self imageNameCheck: tempImageView: @"DisablePU.png"] && !computerPUUsed[0]) {
            if([[computerTimers objectAtIndex:j] isEqual: [[NSNull alloc] init]]) {
                [tempArray addObject:[NSNumber numberWithInt:j]];
                [tempArray addObject:[NSNumber numberWithInt:0]];
                [tempArray addObject:[NSNumber numberWithInt:2]];
                //Limit
                computerPUUsed[0] = true;
                //EndLimit
                [computerTimers replaceObjectAtIndex:j withObject: [NSTimer scheduledTimerWithTimeInterval:.001 target:self selector:@selector(StopAction:) userInfo:tempArray repeats: YES]];
            }
                
        } else if (PU == 1 &&[self imageNameCheck: tempImageView: @"FasterPU.png"]) {
            if([[computerTimers objectAtIndex:j] isEqual: [[NSNull alloc] init]]) {
                [tempArray addObject:[NSNumber numberWithInt:j]];
                [tempArray addObject:[NSNumber numberWithInt:1]];
                [tempArray addObject:[NSNumber numberWithInt:2]];
                computerPUUsed[1] = true;
                //Limit
                playerBallMultiplier*=1.5;
                //Endlimit
                [computerTimers replaceObjectAtIndex:j withObject: [NSTimer scheduledTimerWithTimeInterval:.005 target:self selector:@selector(StopAction:) userInfo:tempArray repeats: YES]];
            }
        } else if (PU == 2 &&[self imageNameCheck: tempImageView: @"SmallerPU.png"]) {
            if([[computerTimers objectAtIndex:j] isEqual: [[NSNull alloc] init]]) {
                [tempArray addObject:[NSNumber numberWithInt:j]];
                [tempArray addObject:[NSNumber numberWithInt:2]];
                [tempArray addObject:[NSNumber numberWithInt:2]];
                computerPUUsed[2] = true;
                //Limit
                paddleLeftObj.height/=2;
                paddleLeft.bounds = CGRectMake(paddleLeft.bounds.origin.x, paddleLeft.bounds.origin.y, paddleLeftObj.width,paddleLeftObj.height);
                //EndLimit
                
                [computerTimers replaceObjectAtIndex:j withObject: [NSTimer scheduledTimerWithTimeInterval:.005 target:self selector:@selector(StopAction:) userInfo:tempArray repeats: YES]];
                    
            }
        } else if (PU == 3 &&[self imageNameCheck: tempImageView: @"WallPU.png"] && !computerPUUsed[3] && !playerPUUsed[3] && ball.center.x < resetPoint.x) {
            if([[computerTimers objectAtIndex:j] isEqual: [[NSNull alloc] init]]) {
                [tempArray addObject:[NSNumber numberWithInt:j]];
                [tempArray addObject:[NSNumber numberWithInt:3]];
                [tempArray addObject:[NSNumber numberWithInt:2]];
                //Limit
                computerPUUsed[3] = true;
                wallImage.hidden = NO;
                //EndLimit
                [computerTimers replaceObjectAtIndex:j withObject: [NSTimer scheduledTimerWithTimeInterval:.005 target:self selector:@selector(StopAction:) userInfo:tempArray repeats: YES]];
            }
        }
    }
    
    
}

+(void) changeStart: (int) score
{
    scoreLimit = score;
}
+(void) changeOptions: (int) amountOfItemsArg : (double) itemDensityArg : (bool) singlePlayerArg :(int) difficultyArg
{
    amountOfItems = amountOfItemsArg;
    itemDensity = itemDensityArg;
    singlePlayer = singlePlayerArg;
    difficulty = difficultyArg;
}

-(void)pause:(id)sender
{
    [self stopTimer];
    [self stopComputerTimer];
    [delayTimer invalidate];
    [self performSegueWithIdentifier:@"gameToPause" sender:sender];
}
-(void) delay
{
    [self stopTimer];
    lastHit = -1;
    delayTimer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(startTimer) userInfo:nil repeats: NO];
}
-(void) AIMove
{
    if (!singlePlayer) return;
    double compMove = 0;
    double amountMove = 1;
    
    if (ball.center.x >= resetPoint.x) {
        if((int)paddleRight.center.y + (int)computerIntersectPoint > (int)ball.center.y && (int)paddleRight.center.y - (int)amountMove > ((int)paddleRightObj.height/2 + 1)) {
            compMove = 0 - amountMove;
        } else if((int)paddleRight.center.y + (int)computerIntersectPoint < (int)ball.center.y && (int)paddleRight.center.y + (int)amountMove < 300 - ((int)paddleRightObj.height/2 + 1)) {
            compMove = amountMove;
        } else {
            compMove = 0;
        }
    }
    if (playerPUUsed[0]) compMove = 0;
    [self moveImage:paddleRight:0:compMove];
    
    if (difficulty == 2) {
        if (!computerPUUsed[3] && ball.center.x < resetPoint.x && ballObj.v_x > 0) {
            [self AIChoosePU:3];
        }
        if (ballObj.v_x < 0) {
            [self AIChoosePU: 1];
            if (ball.center.x < resetPoint.x) {
                [self AIChoosePU:0];
                if (!computerPUUsed[2]) {
                    [self AIChoosePU:2];
                }
            }
        }
    } else {
        if (!computerPUUsed[3] && ball.center.x < resetPoint.x && ballObj.v_x < 0) {
            [self AIChoosePU:3];
        }
        if (ballObj.v_x > 0) {
            [self AIChoosePU: 1];
        }
        
        if (ballObj.v_x < 0) {
            [self AIChoosePU:0];
        }
        
        if (!computerPUUsed[2]) {
            [self AIChoosePU:2];
        }
        
    }
    
    
}

-(double) calculateIntersectPoint
{
    int discrepency = 0;
    int bound = paddleRightObj.height / 2;
    if (difficulty == 0) {
        discrepency = [self randomInt: 0: bound];
        if([self randomInt:1 :3] == 1) {
            discrepency = 0 - discrepency;
        }
    } else if (difficulty == 1) {
        discrepency = [self randomInt: 0: bound];
        if (paddleRight.center.y < paddleLeft.center.y) {
            discrepency = 0 - discrepency;
        }
    } else {
        discrepency = [self randomInt: 0: (bound/2)];
        if (paddleRight.center.y < paddleLeft.center.y) {
            discrepency = 0 - discrepency;
        }
    }
    return discrepency;
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

//CHANGE ALL VERTICAL AND HORIZONTAL BOUNCES SO THAT IT GOES TO A POINT SO THAT THERE ISNT SHAKING BALL
-(void) timerUpdate
{
    int ballXSpeed = 0;
    if ((playerPUUsed[3] && ball.center.x < resetPoint.x && !computerPUUsed[3])) {
        ball.center =  CGPointMake(resetPoint.x + 2, ball.center.y);
        ballObj.v_x = 0 - ballObj.v_x;
    }
    if ((computerPUUsed[3] && ball.center.x > resetPoint.x && !playerPUUsed[3])) {
        ball.center =  CGPointMake(resetPoint.x - 2, ball.center.y);
        ballObj.v_x = 0 - ballObj.v_x;
    }
    
    if (ballObj.v_x < 0) {
        ballXSpeed = ballObj.v_x * playerBallMultiplier;
    } else {
       ballXSpeed = ballObj.v_x * computerBallMultiplier;
    }
    if(ball.center.y <= ballObj.height/2 || ball.center.y >= 300 - ballObj.height/2) {
        ballObj.v_y = 0 - ballObj.v_y;
    }
    CGPoint newpoint = CGPointMake(ball.center.x + ballXSpeed, ball.center.y + ballObj.v_y);
    for (int i = 0; i < [itemsOnScreen count]; i++) {
        UIImageView *tempItemImageView = (UIImageView *) [itemsOnScreen objectAtIndex:i];
        if (CGRectIntersectsRect(tempItemImageView.frame, ball.frame)) {
            
            for (int j = [playerImageViews count] - 1; j >= 0; j--) {
                UIImageView *tempImageView = nil;
                if (lastHit == 0) {
                    tempImageView = (UIImageView *) [playerImageViews objectAtIndex:j];
                } else if(lastHit == 1) {
                    tempImageView = (UIImageView *) [computerImageViews objectAtIndex:j];
                } else {
                    break;
                }
               
                if ([self imageNameCheck:tempImageView: @"blanksquare.png"]) {
                    [tempImageView setImage:tempItemImageView.image];
                    [tempItemImageView removeFromSuperview];
                    [itemsOnScreen removeObjectAtIndex:i];
                    break;
                }
            }
        }
    }
   
    ball.center = newpoint;
    CGPoint leftCenterPoint = CGPointMake(ball.center.x-ballObj.width/2.0, ball.center.y);
    CGPoint rightCenterPoint = CGPointMake(ball.center.x+ballObj.width/2.0, ball.center.y);

    if (CGRectContainsPoint(paddleLeft.frame, leftCenterPoint)) {
        double max_distance = paddleLeftObj.height / 2.0;
        double distance =  (double) (ball.center.y - paddleLeft.center.y);
        double constant = 3.0;
        if(singlePlayer) {
            computerIntersectPoint = [self calculateIntersectPoint];
        }
        //NSLog(@"%d",computerIntersectPoint);
        ballObj.v_x = 0 - ballObj.v_x;
        //MAYBE NEED TO CHANGE SPEED
        ballObj.v_y = (double)(distance / max_distance) * constant;
        ball.center = CGPointMake(ball.center.x + 0.5 * paddleLeftObj.width  + ballObj.v_x, ball.center.y);
        lastHit = 0;
        
    }
    if (CGRectContainsPoint(paddleRight.frame, rightCenterPoint)) {
        double max_distance = paddleRightObj.height / 2.0;
        double distance =  (double) (ball.center.y - paddleRight.center.y);
        double constant = 3.0;
        if(singlePlayer) {
            computerIntersectPoint = [self calculateIntersectPoint];
        }
        ballObj.v_x = 0 - ballObj.v_x;
        ballObj.v_y = (double)(distance / max_distance) * constant;
        ball.center = CGPointMake(ball.center.x - 0.5 * paddleRightObj.width  + ballObj.v_x, ball.center.y);
        lastHit = 1;
    } 
    if(ball.center.x <= 0 - ballObj.width / 2.0) {
        if(singlePlayer) {
            computerIntersectPoint = [self calculateIntersectPoint];
        }
        ball.center = resetPoint;
        ballObj.v_x = 0 - ballObj.v_x;
        if (singlePlayer) {
            computerLabel.text = [[NSString alloc] initWithFormat:@"Computer: %d", ++computerScore];
        } else {
            computerLabel.text = [[NSString alloc] initWithFormat:@"Player Two: %d", ++computerScore];
        }
        
        lastHit = -1;
        [self checkWin];
        [self delay];
        
    } else if (ball.center.x >= self.view.bounds.size.width + (ballObj.width / 2.0)) {
        if(singlePlayer) {
            computerIntersectPoint = [self calculateIntersectPoint];
        }
        ball.center = resetPoint;
        ballObj.v_x = 0 - ballObj.v_x;
        if (singlePlayer){
            playerLabel.text = [[NSString alloc] initWithFormat:@"You: %d", ++playerScore];
        } else {
            playerLabel.text = [[NSString alloc] initWithFormat:@"Player One: %d", ++playerScore];
        }
        
        lastHit = -1;
        [self checkWin];
        [self delay];
        
    }
}
//MAKING SMALLER: paddleLeft.bounds = CGRectMake(xcoordinate, paddleLeft.center.y,
//paddleLeftObj.width,paddleLeftObj.height);

//YES


+(void) setItemList: (NSMutableArray*) array
{
    itemList = array;
}


-(void) addItemsToScreen
{
    
    NSString* powerUpChosen = nil;
    int chooser = [self randomInt:1:([itemList count] + 1)];
    chooser--;
    powerUpChosen = [itemList objectAtIndex:chooser];
    if ([itemsOnScreen count] <= 5) {
        [itemsOnScreen addObject:[[UIImageView alloc] initWithImage:[UIImage imageNamed:powerUpChosen]]];
        UIImageView *tempItemImageView = (UIImageView *) [itemsOnScreen lastObject];
        if(self.view.bounds.size.height == 568) {
            tempItemImageView.frame = CGRectMake([self randomInt:100 :500],[self randomInt:50 :250],24,24); //NEED
        } else {
            tempItemImageView.frame = CGRectMake([self randomInt:50 :250],[self randomInt:50 :250],24,24); //NEED
        }
        
        
        [self.view addSubview:[itemsOnScreen lastObject]];
    }
}

-(void) moveImage: (UIImageView*) image : (double) X_Amount : (double) Y_Amount  {
    CGPoint newpoint = CGPointMake(image.center.x + X_Amount, image.center.y + Y_Amount);
    image.center = newpoint;
}
//YES
-(void) touchesBegan:(NSSet *)touches withEvent:(UIEvent *)event {
    if(touchScreenLabel.hidden == NO) {
        touchScreenLabel.hidden = YES;
        touchScreenLabel.text = @"Touch Screen to Resume";
        computerIntersectPoint = [self calculateIntersectPoint];
        [self startTimer];
        [self startComputerTimer];
    }
    NSArray *touchArray = [touches allObjects];
    for (int i = 0; i < [touchArray count]; i++) {
        CGPoint currentTouchPoint = [[touchArray objectAtIndex:i] locationInView:[self view]];
        for (int j = 0; j < [playerSubViews count]; j++) {
            UIView *tempSubView = (UIView *) [playerSubViews objectAtIndex:j];
            if(CGRectContainsPoint(tempSubView.frame, currentTouchPoint)) {
                UIImageView *tempImageView = [playerImageViews objectAtIndex:j];
                NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                if ([self imageNameCheck: tempImageView: @"DisablePU.png"] && !playerPUUsed[0]) {
                    if([[playerTimers objectAtIndex:j] isEqual: [[NSNull alloc] init]]) {
                        [tempArray addObject:[NSNumber numberWithInt:j]];
                        [tempArray addObject:[NSNumber numberWithInt:0]];
                        [tempArray addObject:[NSNumber numberWithInt:1]];
                        //Limit
                        playerPUUsed[0] = true;
                        //EndLimit
                        [playerTimers replaceObjectAtIndex:j withObject: [NSTimer scheduledTimerWithTimeInterval:.001 target:self selector:@selector(StopAction:) userInfo:tempArray repeats: YES]];
                    }
                    
                } else if ([self imageNameCheck: tempImageView: @"FasterPU.png"]) {
                    if([[playerTimers objectAtIndex:j] isEqual: [[NSNull alloc] init]]) {
                        [tempArray addObject:[NSNumber numberWithInt:j]];
                        [tempArray addObject:[NSNumber numberWithInt:1]];
                        [tempArray addObject:[NSNumber numberWithInt:1]];
                        playerPUUsed[1] = true;
                        //Limit
                        computerBallMultiplier*=1.5;
                        //Endlimit
                        [playerTimers replaceObjectAtIndex:j withObject: [NSTimer scheduledTimerWithTimeInterval:.005 target:self selector:@selector(StopAction:) userInfo:tempArray repeats: YES]];
                    }
                } else if ([self imageNameCheck: tempImageView: @"SmallerPU.png"]) {
                    if([[playerTimers objectAtIndex:j] isEqual: [[NSNull alloc] init]]) {
                        [tempArray addObject:[NSNumber numberWithInt:j]];
                        [tempArray addObject:[NSNumber numberWithInt:2]];
                        [tempArray addObject:[NSNumber numberWithInt:1]];
                        playerPUUsed[2] = true;
                        //Limit
                        paddleRightObj.height/=2;
                        paddleRight.bounds = CGRectMake(paddleRight.bounds.origin.x, paddleRight.bounds.origin.y, paddleRightObj.width,paddleRightObj.height);
                        //EndLimit
                        
                        [playerTimers replaceObjectAtIndex:j withObject: [NSTimer scheduledTimerWithTimeInterval:.005 target:self selector:@selector(StopAction:) userInfo:tempArray repeats: YES]];
                        
                    }
                } else if ([self imageNameCheck: tempImageView: @"WallPU.png"] && !playerPUUsed[3] && !computerPUUsed[3] && ball.center.x > resetPoint.x) {
                    if([[playerTimers objectAtIndex:j] isEqual: [[NSNull alloc] init]]) {
                        [tempArray addObject:[NSNumber numberWithInt:j]];
                        [tempArray addObject:[NSNumber numberWithInt:3]];
                        [tempArray addObject:[NSNumber numberWithInt:1]];
                        //Limit
                        playerPUUsed[3] = true;
                        wallImage.hidden = NO;
                        //EndLimit
                        [playerTimers replaceObjectAtIndex:j withObject: [NSTimer scheduledTimerWithTimeInterval:.005 target:self selector:@selector(StopAction:) userInfo:tempArray repeats: YES]];
                    }
                }
                
            }
        }
        
        
        if (!singlePlayer) {
            for (int j = 0; j < [computerSubViews count]; j++) {
                UIView *tempSubView = (UIView *) [computerSubViews objectAtIndex:j];
                if(CGRectContainsPoint(tempSubView.frame, currentTouchPoint)) {
                    UIImageView *tempImageView = [computerImageViews objectAtIndex:j];
                    NSMutableArray *tempArray = [[NSMutableArray alloc] init];
                    if ([self imageNameCheck: tempImageView: @"DisablePU.png"] && !computerPUUsed[0]) {
                        if([[computerTimers objectAtIndex:j] isEqual: [[NSNull alloc] init]]) {
                            [tempArray addObject:[NSNumber numberWithInt:j]];
                            [tempArray addObject:[NSNumber numberWithInt:0]];
                            [tempArray addObject:[NSNumber numberWithInt:2]];
                            //Limit
                            computerPUUsed[0] = true;
                            //EndLimit
                            [computerTimers replaceObjectAtIndex:j withObject: [NSTimer scheduledTimerWithTimeInterval:.001 target:self selector:@selector(StopAction:) userInfo:tempArray repeats: YES]];
                        }
                        
                    } else if ([self imageNameCheck: tempImageView: @"FasterPU.png"]) {
                        if([[computerTimers objectAtIndex:j] isEqual: [[NSNull alloc] init]]) {
                            [tempArray addObject:[NSNumber numberWithInt:j]];
                            [tempArray addObject:[NSNumber numberWithInt:1]];
                            [tempArray addObject:[NSNumber numberWithInt:2]];
                            computerPUUsed[1] = true;
                            //Limit
                            playerBallMultiplier*=1.5;
                            //Endlimit
                            [computerTimers replaceObjectAtIndex:j withObject: [NSTimer scheduledTimerWithTimeInterval:.005 target:self selector:@selector(StopAction:) userInfo:tempArray repeats: YES]];
                        }
                    } else if ([self imageNameCheck: tempImageView: @"SmallerPU.png"]) {
                        if([[computerTimers objectAtIndex:j] isEqual: [[NSNull alloc] init]]) {
                            [tempArray addObject:[NSNumber numberWithInt:j]];
                            [tempArray addObject:[NSNumber numberWithInt:2]];
                            [tempArray addObject:[NSNumber numberWithInt:2]];
                            computerPUUsed[2] = true;
                            //Limit
                            paddleLeftObj.height/=2;
                            paddleLeft.bounds = CGRectMake(paddleLeft.bounds.origin.x, paddleLeft.bounds.origin.y, paddleLeftObj.width,paddleLeftObj.height);
                            //EndLimit
                            
                            [computerTimers replaceObjectAtIndex:j withObject: [NSTimer scheduledTimerWithTimeInterval:.005 target:self selector:@selector(StopAction:) userInfo:tempArray repeats: YES]];
                            
                        }
                    } else if ([self imageNameCheck: tempImageView: @"WallPU.png"] && !computerPUUsed[3] && !playerPUUsed[3] && ball.center.x < resetPoint.x) {
                        if([[computerTimers objectAtIndex:j] isEqual: [[NSNull alloc] init]]) {
                            [tempArray addObject:[NSNumber numberWithInt:j]];
                            [tempArray addObject:[NSNumber numberWithInt:3]];
                            [tempArray addObject:[NSNumber numberWithInt:2]];
                            wallImage.hidden = NO;
                            //Limit
                            computerPUUsed[3] = true;
                            //EndLimit
                            [computerTimers replaceObjectAtIndex:j withObject: [NSTimer scheduledTimerWithTimeInterval:.005 target:self selector:@selector(StopAction:) userInfo:tempArray repeats: YES]];
                        }
                    }
                }
            }
        }
    }
   
}
-(int) randomInt: (int) low : (int) high
{
    return arc4random() % (high - low) + low;
}

-(void) checkWin
{
    if (computerScore == scoreLimit) {
        [EndGameViewController setWinner: 0: singlePlayer];
        [self performSegueWithIdentifier:@"gameToEnd" sender:nil];
        
    }
    if (playerScore == scoreLimit) {
        [EndGameViewController setWinner: 1: singlePlayer];
        [self performSegueWithIdentifier:@"gameToEnd" sender:nil];
    }
}

-(bool) imageNameCheck: (UIImageView*) imageView : (NSString*) imageName
{
    return imageView.image == [UIImage imageNamed:imageName];
}

- (void) touchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
    NSArray *touchArray = [touches allObjects];
    
    for (int i = 0; i < [touchArray count]; i++) {
        CGPoint currentTouchPoint = [[touchArray objectAtIndex:i] locationInView:[self view]];
        CGRect rectLeft = CGRectMake(0, paddleLeftObj.height / 2, (170.0 / 586) * self.view.bounds.size.width, 300 - paddleLeftObj.height);
        if (CGRectContainsPoint(rectLeft, currentTouchPoint) && !computerPUUsed[0]) {
            CGPoint newPoint = CGPointMake(paddleLeft.center.x,currentTouchPoint.y);
            paddleLeft.center = newPoint;
        }
        
        CGRect rectRight = CGRectMake(self.view.bounds.size.width - (170.0 / 586) * self.view.bounds.size.width, paddleLeftObj.height / 2, (170.0 / 586) * self.view.bounds.size.width, 300 - paddleLeftObj.height);
        if (CGRectContainsPoint(rectRight, currentTouchPoint) && !singlePlayer && !playerPUUsed[0]) {
            CGPoint newPoint = CGPointMake(paddleRight.center.x,currentTouchPoint.y);
            paddleRight.center = newPoint;
        }
        
    }

    
}

//MAYBE
-(void) StopAction: (NSTimer*) theTimer
{
    NSNumber *itemHolderValueTemp = [theTimer.userInfo objectAtIndex:0];
    int itemHolderValue = [itemHolderValueTemp integerValue];
    NSNumber *PUTemp = [theTimer.userInfo objectAtIndex:1];
    int PU = [PUTemp integerValue];
    NSNumber *PlayerTemp = [theTimer.userInfo objectAtIndex:2];
    int player = [PlayerTemp integerValue];
    if (player == 1) {
        if(playerCounts[itemHolderValue] == 1000) {
            playerCounts[itemHolderValue] = 0;
            UIImageView *tempImageView = [playerImageViews objectAtIndex:itemHolderValue];
            [tempImageView setImage:[UIImage imageNamed:@"blanksquare.png"]];
            NSTimer *tempTimer = (NSTimer*) [playerTimers objectAtIndex:itemHolderValue];
            [tempTimer invalidate];
            [playerTimers replaceObjectAtIndex:itemHolderValue withObject:[NSNull null]];
            UIView *tempSubView = [playerSubViews objectAtIndex:itemHolderValue];
            [tempSubView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
            playerPUUsed[PU] = false;
            [self resetPU:PU: player];
        } else {
            UIView *tempSubView = [playerSubViews objectAtIndex:itemHolderValue];
            if (playerColors[itemHolderValue] == 255 || playerColors[itemHolderValue] == 150) {
                playerColorIncrement[itemHolderValue] = 0 - playerColorIncrement[itemHolderValue];
            }
            playerColors[itemHolderValue]+=playerColorIncrement[itemHolderValue];
            [tempSubView setBackgroundColor:[UIColor colorWithRed:1 green:((double) playerColors[itemHolderValue] / 255.0) blue:((double) playerColors[itemHolderValue] / 255.0) alpha:1]];
            playerCounts[itemHolderValue]++;
        }

    } else if (player == 2) {
        if(computerCounts[itemHolderValue] == 1000) {
            computerCounts[itemHolderValue] = 0;
            UIImageView *tempImageView = [computerImageViews objectAtIndex:itemHolderValue];
            [tempImageView setImage:[UIImage imageNamed:@"blanksquare.png"]];
            NSTimer *tempTimer = (NSTimer*) [computerTimers objectAtIndex:itemHolderValue];
            [tempTimer invalidate];
            [computerTimers replaceObjectAtIndex:itemHolderValue withObject:[NSNull null]];
            UIView *tempSubView = [computerSubViews objectAtIndex:itemHolderValue];
            [tempSubView setBackgroundColor:[UIColor colorWithRed:1 green:1 blue:1 alpha:1]];
            computerPUUsed[PU] = false;
            [self resetPU:PU: player];
        } else {
            UIView *tempSubView = [computerSubViews objectAtIndex:itemHolderValue];
            if (computerColors[itemHolderValue] == 255 || computerColors[itemHolderValue] == 150) {
                computerColorIncrement[itemHolderValue] = 0 - computerColorIncrement[itemHolderValue];
            }
            computerColors[itemHolderValue]+=computerColorIncrement[itemHolderValue];
            [tempSubView setBackgroundColor:[UIColor colorWithRed:1 green:((double) computerColors[itemHolderValue] / 255.0) blue:((double) computerColors[itemHolderValue] / 255.0) alpha:1]];
            computerCounts[itemHolderValue]++;
        }

    }
    
}
//MAKE IT SO THAT COMPUTER CAN USE
-(void) resetPU:(int)PU : (int) player
{
    if (player == 1) {
        if (PU == 0) {
        } else if (PU == 1) {
            computerBallMultiplier/=1.5;
        } else if (PU == 2) {
            paddleRightObj.height*=2;
            paddleRight.bounds = CGRectMake(paddleRight.bounds.origin.x, paddleRight.bounds.origin.y, paddleRightObj.width,paddleRightObj.height);
        } else if (PU == 3) {
            wallImage.hidden = YES;
        }
    } else if (player == 2) {
        if (PU == 0) {
        } else if (PU == 1) {
            playerBallMultiplier/=1.5;
        } else if (PU == 2) {
            paddleLeftObj.height*=2;
            paddleLeft.bounds = CGRectMake(paddleLeft.bounds.origin.x, paddleLeft.bounds.origin.y, paddleLeftObj.width,paddleLeftObj.height);
        } else if (PU == 3) {
            wallImage.hidden = YES;
        }
    }
    
}

@end

