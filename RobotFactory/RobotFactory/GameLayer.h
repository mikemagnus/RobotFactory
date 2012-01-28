//
//  GameLayer.h
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameLayer : CCLayer 
{
   CCArray* _robots;
   CCArray* _touchables;
   CCArray* _staticObjects;
}

+(id) scene;

-(void)update:(ccTime)dt;


@end
