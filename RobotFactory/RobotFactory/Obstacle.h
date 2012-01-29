//
//  Obstacle.h
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObject.h"

@interface Obstacle : GameObject <CCTargetedTouchDelegate>
{
   Obstacle* _buddy;
   
   BOOL _isActive;
}

@property(nonatomic,assign)Obstacle* buddy;
@property(nonatomic,setter = setIsActive:)BOOL isActive;

@end
