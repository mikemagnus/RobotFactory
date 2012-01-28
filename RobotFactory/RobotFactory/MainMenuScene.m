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
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Robot Factory" fontName:@"Courier" fontSize:64];
        title.position = ccp(500, 700);
        [self addChild: title];
        
        CCLayer *menuLayer = [[CCLayer alloc] init];
        [self addChild:menuLayer];
        
        CCMenuItemImage *startButton = [CCMenuItemImage itemFromNormalImage:@"startButton.png" selectedImage:@"startButtonSelected.png" target:self selector:@selector(startGame:)];
        
        CCMenu *menu = [CCMenu menuWithItems:startButton, nil];
        [menuLayer addChild: menu];
        
    }
    return self;
}

-(void) startGame: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
}

-(void) dealloc
{
    [super dealloc];
}

@end
