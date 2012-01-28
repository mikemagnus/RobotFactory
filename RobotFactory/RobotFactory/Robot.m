//
//  Robot.m
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Robot.h"


@implementation Robot

@synthesize velocity = _velocity;
@synthesize collision = _collision;

- (id)init 
{
   if ( (self = [super init]) ) 
   {
      _velocity = CGPointZero;
   }
   return self;
}

-(void)update:(ccTime)dt
{
   CGPoint pos = self.position;
   _velocity = ccpClamp(_velocity, ccp(-60.0f,-80.0f), ccp(80.0f,80.0f));
//   self.position = ccpAdd(position_, ccpMult(_velocity, dt));
   if(!flipX_)
   {
      pos.x += _velocity.x * dt;
   }
   else
   {
      pos.x -= _velocity.x * dt;
   }
   pos.y -= _velocity.y * dt;
   self.position = pos;
}

@end
