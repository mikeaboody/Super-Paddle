//
//  Ball.h
//  Super Paddle
//
//  Created by Mike Aboody on 6/26/13.
//  Copyright (c) 2013 Mike Aboody. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface Ball : NSObject
{
    double v_x;
    double v_y;
    int width;
    int height;
}
@property (nonatomic, readwrite) double v_x;
@property (nonatomic, readwrite) double v_y;
@property (nonatomic, readwrite) int width;
@property (nonatomic, readwrite) int height;

@end
