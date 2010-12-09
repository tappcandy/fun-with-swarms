//
//  HelloWorldLayer.m
//  Boids
//
//  Created by Jonathan Williamson on 09/12/2010.
//  Copyright TappCandy 2010. All rights reserved.
//

// Import the interfaces
#import "HelloWorldScene.h"
#import "Boids.h"

// HelloWorld implementation
@implementation HelloWorld

+(id) scene
{
	// 'scene' is an autorelease object.
	CCScene *scene = [CCScene node];
	
	// 'layer' is an autorelease object.
	HelloWorld *layer = [HelloWorld node];
	
	// add layer as a child to scene
	[scene addChild:layer];
	
	// return the scene
	return scene;
}

// on "init" you need to initialize your instance
- (id) init
{
	if((self=[super init]))
	{
		CGSize size = [[CCDirector sharedDirector] winSize];

		
		Simulator *simulator = [[[Simulator alloc] init] autorelease];
		//simulator.position = ccp( size.width /2 , size.height/2 );
		[self addChild:simulator];
	}
	return self;
}

// on "dealloc" you need to release all your retained objects
- (void) dealloc
{
	// in case you have something to dealloc, do it in this method
	// in this particular example nothing needs to be released.
	// cocos2d will automatically release all the children (Label)
	
	// don't forget to call "super dealloc"
	[super dealloc];
}
@end
