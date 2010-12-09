//
//  Boids.m
//  Boids
//
//  Created by Jonathan Williamson on 09/12/2010.
//  Copyright 2010 TappCandy. All rights reserved.
//

#import "Boid.h"
#import "cocos2d.h"

@implementation Boid
@synthesize xpos, ypos, vx, vy;

- (id)init
{
	if((self = [super init]))
	{
		TRAIL_SCALE = 35;
		mySize = 2;
	}
	return self;
}

- (void)draw
{
	glColor4f(0.5, 0.5, 0.5, 1.0);
	glLineWidth(2.0f);
	ccDrawLine(CGPointMake(xpos, ypos),
			   CGPointMake(xpos-TRAIL_SCALE*vx, ypos-TRAIL_SCALE*vy));
}

@end

