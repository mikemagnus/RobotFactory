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
      self.scale = 0.5f;
   }
   return self;
}

-(void)update:(ccTime)dt
{
  
}

@end
