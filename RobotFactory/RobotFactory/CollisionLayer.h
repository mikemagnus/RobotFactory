//
//  CollisionLayer.h
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@class GameObject;

@interface CollisionLayer : CCLayer 
{
   CCArray* _robots;
   CCArray* _touchables;
   CCArray* _staticObjects; 
   
   CGPoint _spawnPoint;
   
   CGPoint _gravity;
}

-(void)addGameObjectToCollision:(GameObject*)collision;
-(void)spawnRobot;

-(void)update:(ccTime)dt;

@end
