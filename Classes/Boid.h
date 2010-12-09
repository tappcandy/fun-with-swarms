//
//  Boids.h
//  Boids
//
//  Created by Jonathan Williamson on 09/12/2010.
//  Copyright 2010 TappCandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface Boid : CCNode
{
	NSInteger TRAIL_SCALE;
	NSInteger mySize;
	
	float xpos, ypos;
	float vx, vy;	
}

- (void)draw;

@property float xpos;
@property float ypos;
@property float vx;
@property float vy;	

@end




