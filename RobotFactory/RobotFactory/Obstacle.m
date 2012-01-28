//
//  Obstacle.m
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "Obstacle.h"


@implementation Obstacle

- (id)init 
{
   if ( (self = [super init]) ) 
   {
      
   }
   return self;
}
-(void)onEnterTransitionDidFinish
{
   [super onEnterTransitionDidFinish];
   [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:0 swallowsTouches:YES];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
   return NO;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
   
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
   
}
@end
