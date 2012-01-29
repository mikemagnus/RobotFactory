//
//  GameLayer.h
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "CollisionLayer.h"
#import "RobotDelegate.h"

#define Z_BACKGROUND 1
#define Z_COLLISION 2
#define Z_MIDDLE 3
#define Z_HUD 6
#define Z_ASSEMBLER 5
#define Z_FOREGROUND 4

@interface GameLayer : CCLayer <CCTargetedTouchDelegate,RobotDelegate>
{
   CollisionLayer* _topLayer;
   CollisionLayer* _bottomLayer;
   
   CCSprite* _topAssembler;
   CCSprite* _topAssemblerJaw;
   CCSprite* _bottomAssembler;
   CCSprite* _bottomAssemblerJaw;
   
   BOOL gamePaused;
   CCSprite* pauseOverlay;
}

+(id) scene;

-(void)update:(ccTime)dt;

-(void)loadAnimations;

@end
