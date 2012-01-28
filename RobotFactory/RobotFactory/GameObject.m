//
//  GameObject.m
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameObject.h"


@implementation GameObject

@synthesize collisionRect = _collisionRect;
@synthesize type = _type;

-(void)setPosition:(CGPoint)position
{
   CGPoint diff = ccpSub(position_,position);
   _collisionRect.origin = ccpAdd(_collisionRect.origin, diff);
   [super setPosition:position];
}

@end
