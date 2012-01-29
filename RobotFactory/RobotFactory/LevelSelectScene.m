//
//  LevelSelectScene.m
//  RobotFactory
//
//  Created by Christopher Lee on 12-01-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectScene.h"
#import "SimpleAudioEngine.h"

@implementation LevelSelectScene

+(id) scene
{
   CCScene *scene = [CCScene node];
   LevelSelectScene *layer = [LevelSelectScene node];
   [scene addChild: layer];
   return scene;
}

-(id) init
{
   if ((self = [super init])) {
      
      [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Robot.mp3" loop:YES];
      
      CGSize winSize = [[CCDirector sharedDirector] winSize];
      
      CCSprite* background = [CCSprite spriteWithFile:@"MenuBackground.png"];
      background.position = ccp(winSize.width / 2, winSize.height/2);
      
      CCMenuItemImage* menuButton = [CCMenuItemImage itemFromNormalImage:@"buttonMainMenu.png" selectedImage:@"buttonMainMenuPressed.png" target:self selector:@selector(menuButton:)];
      
      CCMenu *menu = [CCMenu menuWithItems:menuButton, nil];
      menu.position = ccp(winSize.width/2, winSize.height/2);
      [menu alignItemsVerticallyWithPadding:10];
      
      [self addChild:menu];
      
   }
   return self;
}

@end
