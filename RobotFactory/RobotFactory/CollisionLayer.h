//
//  CollisionLayer.h
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "Robot.h"
#import "RobotDelegate.h"

@class GameObject;

@interface CollisionLayer : CCLayer <RobotDelegate>
{
   CCArray* _spawnArray;
   CCArray* _robots;
   CCArray* _touchables;
   CCArray* _staticObjects; 
   
   CGPoint _spawnPoint;
   
   CGPoint _gravity;
}

-(void)addGameObjectToCollision:(GameObject*)collision;
-(void)addRobotToSpawnArray:(eRobotColor)color;
-(void)spawnRobot:(eRobotColor)color;

-(void)update:(ccTime)dt;
-(CCArray*)collisionsForRobot:(Robot*)robot;
@end
