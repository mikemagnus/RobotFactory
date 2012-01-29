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
      [[CDAudioManager sharedManager] setResignBehavior:kAMRBStopPlay autoHandle:YES];
      
      CGSize winSize = [[CCDirector sharedDirector] winSize];
      
      CCSprite* background = [CCSprite spriteWithFile:@"MenuBackground.png"];
      background.position = ccp(winSize.width / 2, winSize.height/2);
      credits = [CCSprite spriteWithFile:@"MenuCredits.png"];
      credits.position = ccp(winSize.width + 601/2, winSize.height/2);
      creditsOpen = NO;
      creditsMoving = NO;
      
      CCLayer *menuLayer = [[CCLayer alloc] init];
      [self addChild:menuLayer];
      
      CCMenuItemImage *startButton = [CCMenuItemImage itemFromNormalImage:@"MenuButtonPlay.png" selectedImage:@"MenuButtonPlayPress.png" target:self selector:@selector(startGame:)];
      CCMenuItemImage *creditsButton = [CCMenuItemImage itemFromNormalImage:@"MenuButtonCredits.png" selectedImage:@"MenuButtonCreditsPress.png" target:self selector:@selector(toggleCredits:)];
      
      CCMenu *menu = [CCMenu menuWithItems:startButton, creditsButton, nil];
      [menu alignItemsVerticallyWithPadding:27];
      menu.position = ccp(180, winSize.height/2);
      
      [menuLayer addChild:credits z:Z_FOREGROUND];
      [menuLayer addChild:menu z:Z_MIDDLE];
      [menuLayer addChild:background z:Z_BACKGROUND];
      
   }
   return self;
}

-(void) startGame: (id) sender
{
   [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
   [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
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
         [credits runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5 position:ccp(-710, 0)],[CCMoveBy actionWithDuration:0.2 position:ccp(50, 0)], [CCCallFunc actionWithTarget:self selector:@selector(setCreditsNotMoving)], nil]];
      }
   }
}

-(void) setCreditsNotMoving
{
   creditsMoving = FALSE;
}

-(void) dealloc
{
   [super dealloc];
}

@end
