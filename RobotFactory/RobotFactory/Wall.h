//
//  Wall.h
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-29.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObject.h"

@interface Wall : GameObject 
{
   Wall* _buddy;
   BOOL _isActive;
}

@property(nonatomic,assign)Wall* buddy;
@property(nonatomic,setter = setIsActive:)BOOL isActive;

@end
