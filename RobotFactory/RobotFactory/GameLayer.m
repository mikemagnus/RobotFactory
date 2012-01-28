//
//  GameLayer.m
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "GameObject.h"

@implementation GameLayer

+(id) scene
{
   CCScene *scene = [CCScene node];
   GameLayer *layer = [GameLayer node];
   [scene addChild: layer];
   return scene;
}

- (id)init 
{
    if ( (self = [super init]) ) 
    {
        /*CCLabelTTF *message = [CCLabelTTF labelWithString:@"Game start!" fontName:@"Courier" fontSize:32];
        message.position = ccp(500, 200);
        [self addChild: message];*/
       CGSize winSize = [[CCDirector sharedDirector] winSize];
       
       self.isTouchEnabled = YES;
       
       _topLayer = [[CollisionLayer alloc] init];
       _topLayer.position = ccp(0.0f,winSize.height / 2);
       
       CCSprite* background = [CCSprite spriteWithFile:@"Background.png"];
       background.position = ccp(winSize.width / 2, winSize.height/2);
       
       GameObject* base = [GameObject spriteWithFile:@"Belt.png"];
       
       base.position = ccp(winSize.width / 2, winSize.height / 2);

       base.collisionRect = [base boundingBox];
       
       [_topLayer addGameObjectToCollision:base];
       
       [self addChild:background z:Z_BACKGROUND];
       [self addChild:base z:Z_MIDDLE];
       [self addChild:_topLayer z:Z_COLLISION];
       
       [self scheduleUpdate];
    }
    return self;
}

-(void)registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:NO];
}

-(void)update:(ccTime)dt
{
   [_topLayer update:dt];
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
   [_topLayer spawnRobot];
    return YES;
}

-(void)ccTouchMoved:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

-(void)ccTouchEnded:(UITouch *)touch withEvent:(UIEvent *)event
{
    
}

-(void) dealloc
{
    [super dealloc];
}


@end
