//
//  GameObject.h
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

typedef enum GameObjectType
{
   kGameRobot,
   kGameObstacle,
   kGamePlatform
}eGameObjectType;

@interface GameObject : CCSprite 
{
   eGameObjectType _type;
   CGRect         _collisionRect;
}

@property(nonatomic)CGRect collisionRect;

@end
