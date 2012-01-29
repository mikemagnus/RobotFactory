//
//  Wall.m
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-29.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Wall.h"


@implementation Wall

-(id)init
{
   if( (self =[super init]) )
   {
      
   }
   return self;
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



@end
