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
#import "Obstacle.h"


@implementation CollisionLayer

@synthesize spawning = _spawning;

-(id)init
{
   if( (self = [super init]) )
   {
      CGSize winSize = [[CCDirector sharedDirector] winSize];
      _robots = [[CCArray alloc] initWithCapacity:6];
      _touchables = [[CCArray alloc] initWithCapacity:10];
      _staticObjects = [[CCArray alloc] initWithCapacity:10];
      _spawnArray = [[CCArray alloc] initWithCapacity:5];
      
      _spawnPoint = ccp(winSize.width - 80,-37 + 100);
      
      GameObject* conveyorBelt = [GameObject node];
      conveyorBelt.collisionRect = CGRectMake(0.0f, -37.0f, 1024, 50.0f);
      conveyorBelt.type = kGamePlatform;
      [_staticObjects addObject:conveyorBelt];
   }
   return self;
}

-(void)setDelegate:(id)delegate andSelector:(SEL)spawnSel
{
   _delegate = delegate;
   _startSpawnSel = spawnSel;
}

-(void)addGameObjectToCollision:(GameObject *)collision
{
   [_staticObjects addObject:collision];
}

-(void)addObstacleAtPosition:(CGPoint)point
{
   
}

-(void)robotDied:(Robot *)robot
{
   
}

-(void)addRobotToSpawnArray:(eRobotColor)color
{
   [_spawnArray addObject:[[[Robot alloc] initWithRobotColor:color] autorelease]];
}

-(void)spawnRobot:(eRobotColor)color
{
   Robot* rob = [[[Robot alloc] initWithRobotColor:color] autorelease];
//   Robot* rob = [_spawnArray objectAtIndex:0];
//   [_spawnArray removeObjectAtIndex:0];
   [rob runWalk];
   rob.position = _spawnPoint;
   [rob setFlipX:YES];
   [_robots addObject:rob];
   [self addChild:rob];
   
}

-(void)spawnRobot
{
   Robot* rob = [_spawnArray objectAtIndex:0];
   rob.position = _spawnPoint;
   [rob setFlipX:YES];
   [rob runWalk];
   [_robots addObject:rob];
   [self addChild:rob];
   [_spawnArray removeObjectAtIndex:0];
}

-(void)spawnerFinished
{
   
}

#define kGravity 40.0f

-(void)update:(ccTime)dt
{
   if(!_spawning && [_spawnArray count] > 0)
   {
      _spawning = YES;
      [_delegate performSelector:_startSpawnSel];
   }
   
   Robot* rob;
   CCARRAY_FOREACH(_robots, rob)
   {
      rob.velocity = ccpAdd(rob.velocity, ccp(0.0f,40.0f));
      rob.velocity = ccpClamp(rob.velocity, CGPointZero, ccp(120.0f,300.0f));
      if(![rob flipX])
      {
         rob.position = ccpAdd(rob.position,ccp(rob.velocity.x * dt,0.0f));
      }
      else
      {
         rob.position = ccpSub(rob.position,ccp(rob.velocity.x * dt,0.0f));
      }
      CCArray* collisions;
      
      rob.position = ccpSub(rob.position, ccp(0.0f,rob.velocity.y * dt));
      //Check vertical collisions
      if( nil != (collisions = [self collisionsForRobot:rob]) )
      {
         GameObject* obj;
         CCARRAY_FOREACH(collisions, obj)
         {
            if(obj.type == kGameObstacle)
            {
               Obstacle* obstacle = (Obstacle*) obj;
               //Do more complex collision
            }
            else
            {
               rob.velocity = ccp(rob.velocity.x + 40.0f, 0.0f);
               rob.position = ccp(rob.position.x, obj.collisionRect.origin.y + rob.contentSize.height);
            }
         }
      }
      
      //check for horizontal collisions
      if(rob.position.x <= 0.0 + rob.contentSize.width / 2 * rob.scale)
      {
         [rob setFlipX:NO];
      }
      else if(rob.position.x >= 1024.0f - rob.contentSize.width / 2 * rob.scale)
      {
         [rob setFlipX:YES];
      }
      if( (collisions = [self collisionsForRobot:rob]) )
      {
         GameObject* obj;
         CCARRAY_FOREACH(collisions, obj)
         {
            if(obj.type == kGameObstacle)
            {
               Obstacle* obstacle = (Obstacle*) obj;
               //Do more complex collision
            }
            else
            {
               [rob setFlipX:!rob.flipX];
            }
         }
      }
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

-(CCArray*)collisionsForRobot:(Robot*)robot
{
   CCArray* collisions = nil;
   //Static objects
   GameObject* obj;
   CCARRAY_FOREACH(_staticObjects, obj)
   {
      if(CGRectIntersectsRect([robot boundingBox], [obj collisionRect]))
      {
         if(nil == collisions)
            collisions = [[CCArray alloc] initWithCapacity:3];
         [collisions addObject:obj];
      }
   }
   return collisions;
}

@end
