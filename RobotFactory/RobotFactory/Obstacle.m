//
//  Obstacle.m
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Obstacle.h"
#import "Robot.h"


@implementation Obstacle

@synthesize buddy = _buddy;
@synthesize isActive = _isActive;

- (id)init 
{
   if ( (self = [super init]) ) 
   {
      _type = kGameObstacle;
      _isActive = NO;
      self.visible = NO;
   }
   return self;
}

-(void)didCollideWithRobot:(Robot*)robot
{
   [robot runDeath];
}

-(void)setIsActive:(BOOL)isActive
{
   if(_isActive == isActive)
      return;
   _isActive = isActive;
   CCAnimation* anim = [[CCAnimationCache sharedAnimationCache] animationByName:@"TeslaCoil_default"];
   if(!isActive)
   {
      [self runAction:[CCSequence actions:[CCAnimate actionWithAnimation:anim restoreOriginalFrame:NO],[CCCallFunc actionWithTarget:self selector:@selector(doneAnim)],nil]];
   }
   else
   {
      self.visible = YES;
      [self runAction:[CCSequence actions:[CCReverseTime actionWithAction:[CCAnimate actionWithAnimation:anim restoreOriginalFrame:NO]],[CCCallFunc actionWithTarget:self selector:@selector(doneAnim)],nil]];
   }
}

-(void)doneAnim
{
   if(!_isActive)
   {
      [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"GameTeslaCoil4.png"]];
      self.visible = NO;
   }
   else
   {
      [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"GameTeslaCoil1.png"]];
   }
}

-(void)onEnterTransitionDidFinish
{
   [super onEnterTransitionDidFinish];
   [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
   CGPoint tp = [self convertTouchToNodeSpace:touch];
   NSLog(@"TP: %@ Rect: %@",NSStringFromCGPoint(tp),NSStringFromCGRect([self boundingBox]));
   if(CGRectContainsPoint([self textureRect], tp))
   {
      if(touch.tapCount == 1)
      {
         _buddy.isActive = self.isActive;
         self.isActive = !self.isActive;
      }
      return YES;
   }
   return NO;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
   
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
   
}
@end
