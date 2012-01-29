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

@protocol RobotDelegate;

@interface Robot : GameObject 
{
    CGPoint _velocity;
   
   BOOL     _isDieing;
   
    GameObject* _collision;
    
   eRobotColor _robColor;
   
   id<RobotDelegate> _delegate;
}

@property(nonatomic)CGPoint velocity;
@property(nonatomic)BOOL isDieing;
@property(nonatomic)GameObject* collision;
@property(nonatomic)eRobotColor robColor;

-(id)initWithRobotColor:(eRobotColor)color;

-(void)update:(ccTime)dt;

-(void)setDelegate:(id<RobotDelegate>)delegate;

-(void)runWalk;
-(void)runDeath;
-(void)runWin;

-(void)deathFinished;

@end
