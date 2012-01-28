//
//  Robot.h
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObject.h"

typedef enum RobotColor
{
    kRobotColorBlue,
    kRobotColorRed
}eRobotColor;


@interface Robot : GameObject 
{
    CGPoint _velocity;
   
    GameObject* _collision;
    
    eRobotColor _color;
}

@property(nonatomic)CGPoint velocity;
@property(nonatomic)GameObject* collision;

-(void)update:(ccTime)dt;

@end
