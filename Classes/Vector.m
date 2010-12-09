//
//  Vector.m
//  Boids
//
//  Created by Jonathan Williamson on 09/12/2010.
//  Copyright 2010 TappCandy. All rights reserved.
//

#import "Vector.h"


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
