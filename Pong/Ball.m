//
//  Ball.m
//  Super Paddle
//
//  Created by Mike Aboody on 6/26/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import "Ball.h"

@implementation Ball
@synthesize v_x, v_y, width, height;
- (id) init
{
    v_x = 4.0;
    v_y = 0;
    width = 15;
    height = 15;
    return self;
    //4.0
    //2.0
}

@end
