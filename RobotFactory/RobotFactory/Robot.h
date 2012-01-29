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
    
   eRobotColor _robColor;
}

@property(nonatomic)CGPoint velocity;
@property(nonatomic)GameObject* collision;
@property(nonatomic)eRobotColor robColor;

-(void)update:(ccTime)dt;

-(void)runWalk;
-(void)runDeath;

-(void)deathFinished;

@end
