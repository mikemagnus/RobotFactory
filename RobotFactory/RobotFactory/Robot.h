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

@interface Robot : GameObject 
{
   CGPoint _velocity;
   
   GameObject* _collision;
}

@property(nonatomic)CGPoint velocity;
@property(nonatomic)GameObject* collision;


-(void)update:(ccTime)dt;

@end
