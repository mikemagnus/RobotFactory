//
//  Robot.m
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Robot.h"
#import "RobotDelegate.h"


@implementation Robot

@synthesize velocity = _velocity;
@synthesize collision = _collision;
@synthesize robColor = _robColor;

- (id)init
{
   if ( (self = [super init]) ) 
   {
      _velocity = CGPointZero;
//      self.scale = 0.5f;
   }
   return self;
}

-(void)setDelegate:(id<RobotDelegate>)delegate
{
   _delegate = delegate;
}

-(void)runWalk
{
   CCAnimation* animation;
   if(_robColor == kRobotColorRed)
   {
      animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"redWalk"];
   }
   else if(_robColor == kRobotColorBlue)
   {
      animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"blueWalk"];
   }
   [self runAction:[CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO]]];
}

-(void)runDeath
{
   
}

-(void)deathFinished
{
   
}

-(void)update:(ccTime)dt
{
  
}

@end
