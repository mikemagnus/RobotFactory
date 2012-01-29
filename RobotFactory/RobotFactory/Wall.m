//
//  Wall.m
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-29.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Wall.h"


@implementation Wall

@synthesize isActive = _isActive;
@synthesize buddy = _buddy;

-(id)init
{
   if( (self =[super init]) )
   {
      _type = kGameWall;
      _isActive = NO;
      self.visible = NO;
   }
   return self;
}

-(void)onEnterTransitionDidFinish
{
   [super onEnterTransitionDidFinish];
   [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(void)setIsActive:(BOOL)isActive
{
   if(_isActive == isActive)
      return;
   _isActive = isActive;
   CCAnimation* anim = [[CCAnimationCache sharedAnimationCache] animationByName:@"GameWall_default"];
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
//      [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"GameTeslaCoil4.png"]];
      self.visible = NO;
   }
   else
   {
//      [self setDisplayFrame:[[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:@"GameTeslaCoil1.png"]];
//      glow.visible = YES;
//      [glow runAction:[CCRepeatForever actionWithAction:[CCSequence actions:[CCFadeIn actionWithDuration:1.0f],[CCFadeOut actionWithDuration:1.0f], nil]]];
   }
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
   if([[CCDirector sharedDirector] isPaused])
      return NO;
   CGPoint tp = [self convertTouchToNodeSpace:touch];
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
