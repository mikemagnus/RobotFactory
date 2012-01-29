//
//  MainMenuScene.m
//  RobotFactory
//
//  Created by Christopher Lee on 12-01-28.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "MainMenuScene.h"
#import "CCLabelTTF.h"
#import "CCDirector.h"
#import "SimpleAudioEngine.h"
#import "GameLayer.h"
#import "HelloWorldLayer.h"

@implementation MainMenuScene

+(id) scene
{
   CCScene *scene = [CCScene node];
   MainMenuScene *layer = [MainMenuScene node];
   [scene addChild: layer];
   return scene;
}

-(id) init
{
   if ((self = [super init])) {
      
      [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Robot.mp3" loop:YES];
      
      CGSize winSize = [[CCDirector sharedDirector] winSize];
      CCSprite* background = [CCSprite spriteWithFile:@"mainMenu.png"];
      background.position = ccp(winSize.width / 2, winSize.height/2);
      
      CCLayer *menuLayer = [[CCLayer alloc] init];
      [self addChild:menuLayer];
      
      CCMenuItemImage *startButton = [CCMenuItemImage itemFromNormalImage:@"Play-static.png" selectedImage:@"Play-pressed.png" target:self selector:@selector(startGame:)];
      CCMenuItemImage *creditsButton = [CCMenuItemImage itemFromNormalImage:@"Credits-static.png" selectedImage:@"Credits-pressed.png" target:self selector:@selector(viewCredits:)];
      
      CCMenu *menu = [CCMenu menuWithItems:startButton, creditsButton, nil];
      [menu alignItemsVerticallyWithPadding:20];
      menu.position = ccp(600, 100);
      menu.scale = 0.65;
      
      [menuLayer addChild:menu z:Z_FOREGROUND];
      [menuLayer addChild:background z:Z_BACKGROUND];
      
   }
   return self;
}

-(void) startGame: (id) sender
{
   [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
   [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
}

-(void) viewCredits: (id) sender
{
   [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
}

-(void) dealloc
{
   [super dealloc];
}

@end
