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
      [[CDAudioManager sharedManager] setResignBehavior:kAMRBStopPlay autoHandle:YES];
      
      CGSize winSize = [[CCDirector sharedDirector] winSize];
      
      CCSprite* background = [CCSprite spriteWithFile:@"MenuBackground.png"];
      background.position = ccp(winSize.width / 2, winSize.height/2);
      
      credits = [CCSprite spriteWithFile:@"MenuCredits.png"];
      credits.position = ccp(winSize.width + 601/2, winSize.height/2);
      creditsOpen = NO;
      creditsMoving = NO;
      
      levelSelect = [[CCLayer alloc] init];
      levelSelectOverlay = [CCSprite spriteWithFile:@"mainMenuOverlay.png"];
      levelSelect.position = ccp(winSize.width + 601/2, winSize.height/2);
      levelSelectOpen = NO;
      levelSelectOpen = NO;
      
      CCMenuItemImage *lvl1Button = [CCMenuItemImage itemFromNormalImage:@"buttonLevel1.png" selectedImage:@"buttonLevel1Pressed.png" target:self selector:@selector(goToLevel1:)];
      lvl1Button.scale = 0.4;
      CCMenuItemImage *lvl2Button = [CCMenuItemImage itemFromNormalImage:@"buttonLevel2.png" selectedImage:@"buttonLevel2Pressed.png" target:self selector:@selector(goToLevel2:)];
      lvl2Button.scale = 0.4;
      CCMenuItemImage *lvl3Button = [CCMenuItemImage itemFromNormalImage:@"buttonLevel3.png" selectedImage:@"buttonLevel3Pressed.png" target:self selector:@selector(goToLevel3:)];
      lvl3Button.scale = 0.4;
      
      CCMenu* lvlMenu = [CCMenu menuWithItems:lvl1Button, lvl2Button, lvl3Button, nil];
      [lvlMenu alignItemsVerticallyWithPadding:25];
      lvlMenu.position = ccp(112, 0);
      
      [levelSelect addChild:levelSelectOverlay z:Z_BACKGROUND];
      [levelSelect addChild:lvlMenu z:Z_FOREGROUND];
      
      CCLayer *menuLayer = [[CCLayer alloc] init];
      [self addChild:menuLayer];
      
      CCMenuItemImage *startButton = [CCMenuItemImage itemFromNormalImage:@"MenuButtonPlay.png" selectedImage:@"MenuButtonPlayPress.png" target:self selector:@selector(toggleLevelSelect:)];
      CCMenuItemImage *creditsButton = [CCMenuItemImage itemFromNormalImage:@"MenuButtonCredits.png" selectedImage:@"MenuButtonCreditsPress.png" target:self selector:@selector(toggleCredits:)];
      
      CCMenu *menu = [CCMenu menuWithItems:startButton, creditsButton, nil];
      [menu alignItemsVerticallyWithPadding:27];
      menu.position = ccp(180, winSize.height/2);
      
      [menuLayer addChild:credits z:Z_FOREGROUND];
      [menuLayer addChild:levelSelect z:Z_FOREGROUND];
      [menuLayer addChild:menu z:Z_MIDDLE];
      [menuLayer addChild:background z:Z_BACKGROUND];
      
   }
   return self;
}

-(void) toggleCredits: (id) sender
{
   if (!creditsMoving) {
      creditsMoving = YES;
      if (creditsOpen) {
         creditsOpen = NO;
         [credits runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.2 position:ccp(-50, 0)],[CCMoveBy actionWithDuration:0.5 position:ccp(710, 0)], [CCCallFunc actionWithTarget:self selector:@selector(setCreditsNotMoving)], nil]];
      } else {
         creditsOpen = YES;
         if (levelSelectOpen) {
            [credits runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.9],[CCMoveBy actionWithDuration:0.5 position:ccp(-710, 0)],[CCMoveBy actionWithDuration:0.2 position:ccp(50, 0)], [CCCallFunc actionWithTarget:self selector:@selector(setCreditsNotMoving)], nil]];
         } else {
            [credits runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(-710, 0)],[CCMoveBy actionWithDuration:0.2 position:ccp(50, 0)], [CCCallFunc actionWithTarget:self selector:@selector(setCreditsNotMoving)], nil]];
         }
      }
      if (levelSelectOpen) {
         [self toggleLevelSelect:self];
      }
   }
}

-(void) setCreditsNotMoving
{
   creditsMoving = NO;
}

-(void) toggleLevelSelect: (id) sender
{
   if (!levelSelectMoving) {
      levelSelectMoving = YES;
      if (levelSelectOpen) {
         levelSelectOpen = NO;
         [levelSelect runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.2 position:ccp(-50, 0)],[CCMoveBy actionWithDuration:0.5 position:ccp(710, 0)], [CCCallFunc actionWithTarget:self selector:@selector(setLevelSelectNotMoving)], nil]];
      } else {
         levelSelectOpen = YES;
         if (creditsOpen) {
            [levelSelect runAction:[CCSequence actions:[CCDelayTime actionWithDuration:0.9],[CCMoveBy actionWithDuration:0.5 position:ccp(-710, 0)],[CCMoveBy actionWithDuration:0.2 position:ccp(50, 0)], [CCCallFunc actionWithTarget:self selector:@selector(setLevelSelectNotMoving)], nil]];
         } else {
            [levelSelect runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(-710, 0)],[CCMoveBy actionWithDuration:0.2 position:ccp(50, 0)], [CCCallFunc actionWithTarget:self selector:@selector(setLevelSelectNotMoving)], nil]];
         }
      }
      if (creditsOpen) {
         [self toggleCredits:self];
      }
   }
}

-(void) setLevelSelectNotMoving
{
   levelSelectMoving = NO;
}

-(void) goToLevel1: (id) sender
{
   [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
   [[CCDirector sharedDirector] replaceScene:[GameLayer sceneWithIndex:1]];
}

-(void) goToLevel2: (id) sender
{
   [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
   [[CCDirector sharedDirector] replaceScene:[GameLayer sceneWithIndex:2]];
}

-(void) goToLevel3: (id) sender
{
   [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
   [[CCDirector sharedDirector] replaceScene:[GameLayer sceneWithIndex:3]];
}

-(void) dealloc
{
   [super dealloc];
}

@end
