//
//  HelloWorldLayer.m
//  Boids
//
//  Created by Jonathan Williamson on 09/12/2010.
//  Copyright TappCandy 2010. All rights reserved.
//

#import "BoidsScene.h"
#import "Simulator.h"

@implementation Boids

+ (id)scene
{
	CCScene *scene = [CCScene node];
	
	Boids *layer = [Boids node];	
	[scene addChild:layer];
	
	return scene;
}

- (id)init
{
	if((self = [super init]))
	{
		Simulator *simulator = [[[Simulator alloc] init] autorelease];
		[self addChild:simulator];
	}
	return self;
}

@end
