//
//  Simulator.h
//  Boids
//
//  Created by Jonathan Williamson on 09/12/2010.
//  Copyright 2010 TappCandy. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class Vector;
@class Boid;

@interface Simulator : CCLayer
{
	NSMutableArray *flock;
	CGPoint touchLocation;
}

- (void)draw;
- (void)updateFlock;
- (void)limitVelocity:(Boid *)b;
- (Vector *)rule1:(Boid *)b;
- (Vector *)rule2:(Boid *)b;
- (Vector *)rule3:(Boid *)b;
- (Vector *)rule4:(Boid *)b;
- (float)distanceBetween:(Boid *)v1 and:(Boid *)v2;

@end
