//
//  Boids.m
//  Boids
//
//  Created by Jonathan Williamson on 09/12/2010.
//  Copyright 2010 TappCandy. All rights reserved.
//

#import "Boids.h"
#import "cocos2d.h"

// Flocking 1

const int NUM_BOIDS = 50;
const int CENTER_PULL_FACTOR = 80000;
const float BOUNCE_ABSORPTION = 0.75;

//----------------

@implementation Vector
@synthesize x, y;

- (id)init
{
	if((self = [super init]))
	{
		x = 0;
		y = 0;
	}
	return self;
}

- (id)initWithX:(float)_x andY:(float)_y
{
	if((self = [super init]))
	{
		x = x;
		y = y;
	}
	return self;
}

@end

//----------------

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

//----------------

@implementation Simulator

- (id)init
{
	if((self = [super init]))
	{
		srand(time(NULL));
		
		flock = [[NSMutableArray alloc] init];
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		for(int i=0; i<NUM_BOIDS; ++i)
		{
			Boid *boid = [[Boid alloc] init];
			boid.xpos = rand()%((NSInteger)winSize.width);
			boid.ypos = rand()%((NSInteger)winSize.height);
			boid.vx = boid.vy = (rand()%1) - 0.5;
			[flock addObject:boid];
			[self addChild:boid];
			[boid release];
		}
		
		self.isTouchEnabled = YES;
	}
	return self;
}

- (void)dealloc
{
	[flock release];
	[super dealloc];
}

- (void)ccTouchesBegan:(NSSet*)touches withEvent:(UIEvent*)event
{
	UITouch *touch = [touches anyObject];
	CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];
	
	touchLocation = location;
}

- (void)ccTouchesMoved:(NSSet *)touches withEvent:(UIEvent *)event
{
	UITouch *touch = [touches anyObject];
	CGPoint location = [[CCDirector sharedDirector] convertToGL:[touch locationInView:touch.view]];
	
	touchLocation = location;
}

- (void)draw
{  
	for(Boid *boid in flock)
	{
		//NSDate *date = [NSDate date];
		[boid draw];
		//NSLog(@"Drawn in : %f", [[NSDate date] timeIntervalSinceDate:date]);
		//date = [NSDate date];
		[self updateFlock];
		//NSLog(@"Updated in : %f", [[NSDate date] timeIntervalSinceDate:date]);
	}
}

- (void)updateFlock
{
	for(Boid *boid in flock)
	{
		Vector *v1 = [self rule1:boid];
		Vector *v2 = [self rule2:boid];
		Vector *v3 = [self rule3:boid];
		Vector *v4 = [self rule4:boid];
		
		// add vectors to velocities
		boid.vx += v1.x + v2.x + v3.x + v4.x;
		boid.vy += v1.y + v2.y + v3.y + v4.y;
				
		[self limitVelocity:boid];
		
		// update new position with previously calculated velocities
		boid.xpos += boid.vx;
		boid.ypos += boid.vy;
		
		CGSize winSize = [[CCDirector sharedDirector] winSize];
		
		if (boid.xpos < 0 || boid.xpos > winSize.width)
			boid.vx = -boid.vx * BOUNCE_ABSORPTION;
		
		if (boid.ypos < 0 || boid.ypos > winSize.height)
			boid.vy = -boid.vy * BOUNCE_ABSORPTION;
		
	}
}

- (void)limitVelocity:(Boid *)boid
{
	float vlim = 1.5;
	
	float velocity = sqrt((boid.vx*boid.vx) + (boid.vy*boid.vy));
	
	if (velocity > vlim)
	{
		float vx = (boid.vx/velocity)/vlim;
		float vy = (boid.vy/velocity)/vlim;
		boid.vx = vx;
		boid.vy = vy;
	}  	
}


- (Vector *)rule1:(Boid *)b
{
	Vector *pc = [[Vector alloc] init];
	
	for(Boid *boid in flock)
	{
		if (b != boid)
		{
			pc.x += boid.xpos;
			pc.y += boid.ypos;
		}
	}
	
	pc.x /= (NUM_BOIDS-1);
	pc.y /= (NUM_BOIDS-1);
	
	pc.x = (pc.x - b.xpos) / CENTER_PULL_FACTOR;
	pc.y = (pc.y - b.ypos) / CENTER_PULL_FACTOR;
	
	return [pc autorelease];
}

- (Vector *)rule2:(Boid *)b
{
	Vector *v = [[Vector alloc] init];
	
	for(Boid *boid in flock)
	{
		if (b != boid)
		{
			if(distance2d(b, boid) < 20)
			{
				v.x -= boid.xpos - b.xpos;
				v.y -= boid.ypos - b.ypos;
			}
		}
	}
	
	return [v autorelease];
}

- (Vector *)rule3:(Boid *)b
{
	Vector *v  = [[Vector alloc] init];
	
	for(Boid *boid in flock)
	{
		if (b != boid)
		{
			v.x += b.vx;
			v.y += b.vy;
		}
	}
	
	v.x /= (NUM_BOIDS - 1);
	v.y /= (NUM_BOIDS - 1);
	
	v.x = (v.x - b.vx)/8;
	v.y = (v.y - b.vy)/8;
	
	return [v autorelease];
}

- (Vector *)rule4:(Boid *)b
{
	Vector *v = [[Vector alloc] init];
	
	v.x = (touchLocation.x - b.xpos) / CENTER_PULL_FACTOR;
	v.y = (touchLocation.y - b.ypos) / CENTER_PULL_FACTOR;
	
	return [v autorelease];
}

float distance2d(Boid *v1, Boid *v2)
{
	float x = abs(v1.xpos - v2.xpos);
	float y = abs(v1.ypos - v2.ypos);
	
	return sqrt((x*x) + (y*y));
}

@end
