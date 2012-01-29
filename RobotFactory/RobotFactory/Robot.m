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
@synthesize isDieing = _isDieing;
@synthesize robColor = _robColor;

- (id)initWithRobotColor:(eRobotColor)color
{
   NSString* file;
   if(color == kRobotColorRed)
   {
      file = @"RoboRed_00000_1.png";
   }
   else
   {
      file = @"RoboBlue_00000.png";
   }
   if ( (self = [super initWithSpriteFrameName:file]) ) 
   {
      _velocity = CGPointZero;
      _robColor = color;
      _type = kGameRobot;
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
   //Run the death animation
   //Run in sequence to call deathFinished once complete
   self.position = ccpAdd(position_,ccp(0.0f,10.0f));
   _isDieing = YES;
   CCAnimation* animation;
   if(_robColor == kRobotColorRed)
   {
      animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"redDeath"];
   }
   else if(_robColor == kRobotColorBlue)
   {
      animation = [[CCAnimationCache sharedAnimationCache] animationByName:@"blueDeath"];
   }
   [self runAction:[CCSequence actions:[CCAnimate actionWithAnimation:animation restoreOriginalFrame:NO],[CCCallFunc actionWithTarget:self selector:@selector(deathFinished)],nil]];
   [self runAction:[CCFadeOut actionWithDuration:1.0f]];
}

-(void)deathFinished
{
   //Fade/remove
   [_delegate robotDied:self];
   //Add to opposite side
}

-(void)update:(ccTime)dt
{
  
}

@end
