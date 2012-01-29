//
//  MainMenuScene.h
//  RobotFactory
//
//  Created by Christopher Lee on 12-01-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "cocos2d.h"

@interface MainMenuScene : CCLayer
{
   CCSprite* credits;
   BOOL creditsOpen;
   BOOL creditsMoving;
}

+(id) scene;

@end
