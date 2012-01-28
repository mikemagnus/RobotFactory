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
       
       _bottomLayer = [[CollisionLayer alloc] init];
       _bottomLayer.position = ccp(0.0f,-(winSize.height / 2));
       _bottomLayer.rotation = 180.0f;
       
       CCSprite* background = [CCSprite spriteWithFile:@"Background.png"];
       background.position = ccp(winSize.width / 2, winSize.height/2);
       
       GameObject* base = [GameObject spriteWithFile:@"Belt.png"];
       base.scaleY = 0.5f;
       
       base.position = ccp(winSize.width / 2, winSize.height / 2);

       base.collisionRect = [base boundingBox];
       
//       [_topLayer addGameObjectToCollision:base];
       
       [self addChild:background z:Z_BACKGROUND];
       [self addChild:base z:Z_MIDDLE];
       [self addChild:_topLayer z:Z_COLLISION];
       [self addChild:_bottomLayer z:Z_COLLISION];
       
       [self scheduleUpdate];
       [self loadAnimations];
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
   [_bottomLayer update:dt];
}

#define ANIMATION_DELAY 1/30.0f

-(void)loadAnimations
{
   [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"roboblue.plist"];
   CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"roboblue.png"];
   [self addChild:spriteSheet];
   NSMutableArray *walkAnimFrames = [NSMutableArray array];
   for (int i=0; i<20; i++) {
      [walkAnimFrames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"RoboBlueSmall_000%02d.png", i]]];
   }
   
   CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:ANIMATION_DELAY];
   [[CCAnimationCache sharedAnimationCache] addAnimation:walkAnim name:@"walk"]; 
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
   [_topLayer spawnRobot];
   [_bottomLayer spawnRobot];
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
