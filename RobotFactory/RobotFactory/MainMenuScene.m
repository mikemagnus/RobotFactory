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
        
        CCLabelTTF *title = [CCLabelTTF labelWithString:@"Robot Factory" fontName:@"Arial" fontSize:64];
        title.position = ccp(500, 700);
        [self addChild: title];
        
        CCLayer *menuLayer = [[CCLayer alloc] init];
        [self addChild:menuLayer];
        
        [CCMenuItemFont setFontSize:64];
        
        CCMenuItem *menuItem1 = [CCMenuItemFont itemFromString:@"Play" target:self selector:@selector(onPlay:)];
        CCMenuItem *menuItem2 = [CCMenuItemFont itemFromString:@"Settings" target:self selector:@selector(onHow:)];
        CCMenuItem *menuItem3 = [CCMenuItemFont itemFromString:@"About" target:self selector:@selector(onAbout:)];
        
        //CCMenuItemImage *startButton = [CCMenuItemImage itemFromNormalImage:@"startButton.png" selectedImage:@"startButtonSelected.png" target:self selector:@selector(startGame:)];
        
        CCMenu *menu = [CCMenu menuWithItems:menuItem1, menuItem2, menuItem3, nil];
        [menu alignItemsVertically];
        [menuLayer addChild: menu];
        
    }
    return self;
}

-(void) onPlay: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[GameLayer scene]];
}

-(void) onHow: (id) sender
{
    NSLog(@"Go to 'how to play' screen");
}

-(void) onAbout: (id) sender
{
    [[CCDirector sharedDirector] replaceScene:[HelloWorldLayer scene]];
}

-(void) dealloc
{
    [super dealloc];
}

@end
