//
//  CollisionLayer.m
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "CollisionLayer.h"

#import "GameObject.h"
#import "Robot.h"


@implementation CollisionLayer

-(id)init
{
   if( (self = [super init]) )
   {
      CGSize winSize = [[CCDirector sharedDirector] winSize];
      _robots = [[CCArray alloc] initWithCapacity:6];
      _touchables = [[CCArray alloc] initWithCapacity:10];
      _staticObjects = [[CCArray alloc] initWithCapacity:10];
      
      _spawnPoint = ccp(winSize.width - 80,110);
   }
   return self;
}

-(void)addGameObjectToCollision:(GameObject *)collision
{
   [_staticObjects addObject:collision];
}

-(void)spawnRobot
{
   Robot* rob = [Robot spriteWithFile:@"robobo.png"];
   rob.position = _spawnPoint;
   [rob setFlipX:YES];
   [_robots addObject:rob];
   [self addChild:rob];
}

#define kGravity 40.0f

-(void)update:(ccTime)dt
{
   Robot* rob;
   CCARRAY_FOREACH(_robots, rob)
   {
      if(rob.position.x <= 0.0 + rob.contentSize.width / 2)
      {
         [rob setFlipX:NO];
      }
      else if(rob.position.x >= 1024.0f - rob.contentSize.width / 2)
      {
         [rob setFlipX:YES];
      }
      rob.velocity = ccpAdd(rob.velocity, ccp(20.0f,0.0f));
      [rob update:dt];
      GameObject* obj;
      CCARRAY_FOREACH(_staticObjects, obj)
      {
         if(rob.velocity.y > 0)
         {
            rob.collision = obj;
         }
      }
   }
}

@end
