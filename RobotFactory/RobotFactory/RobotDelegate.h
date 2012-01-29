//
//  RobotDelegate.h
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>

@class Robot;
@class CollisionLayer;

@protocol RobotDelegate <NSObject>

-(void)robotDied:(Robot*)robot;

@end
