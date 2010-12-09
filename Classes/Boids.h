//
//  Boids.h
//  Boids
//
//  Created by Jonathan Williamson on 09/12/2010.
//  Copyright 2010 TappCandy. All rights reserved.
//

#import <Foundation/Foundation.h>

#import "cocos2d.h"

@interface Vector : NSObject
{
	float x, y;
}

@property float x;
@property float y;

@end



@interface Boid : CCNode
{
	NSInteger TRAIL_SCALE;
	NSInteger mySize;
	
	float xpos, ypos;
	float vx, vy;	
}

- (void)draw;//:(ccTime)deltaT;

@property float xpos;
@property float ypos;
@property float vx;
@property float vy;	

@end



@interface Simulator : CCLayer
{
	NSMutableArray *flock;
	/*Vector *v1;
	Vector *v2;
	Vector *v3;
	Vector *v4;*/
	
	CGPoint touchLocation;
}

- (void)draw;//:(ccTime)deltaT;
- (void)updateFlock;
- (void)limitVelocity:(Boid *)b;
- (Vector *)rule1:(Boid *)b;
- (Vector *)rule2:(Boid *)b;
- (Vector *)rule3:(Boid *)b;
- (Vector *)rule4:(Boid *)b;

float distance2d(Boid *v1, Boid *v2);

@end
