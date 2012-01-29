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
       [_topLayer setDelegate:self andSelector:@selector(startTopSpawn)];
       
       _bottomLayer = [[CollisionLayer alloc] init];
       _bottomLayer.position = ccp(0.0f,-(winSize.height / 2));
       [_bottomLayer setDelegate:self andSelector:@selector(startBottomSpawn)];
       _bottomLayer.rotation = 180.0f;
       
       CCSprite* background = [CCSprite spriteWithFile:@"Background01.png"];
       background.position = ccp(winSize.width / 2, winSize.height/2);
       
       GameObject* base = [GameObject spriteWithFile:@"Belt.png"];
//       base.scaleY = 0.5f;
       
       base.position = ccp(winSize.width / 2, winSize.height / 2);

       base.collisionRect = [base boundingBox];
       
//       [_topLayer addGameObjectToCollision:base];
       
       
       CCSprite* foreground = [CCSprite spriteWithFile:@"Gear-Overlay.png"];
       foreground.position = ccp(winSize.width / 2, winSize.height/2);
       
       _topAssembler = [CCSprite spriteWithFile:@"GameAssembler.png"];
       _topAssemblerJaw = [CCSprite spriteWithFile:@"GameAssemblerMouth.png"];
       _topAssemblerJaw.position = ccp(_topAssemblerJaw.contentSize.width/2 + 17.0f,0.0f);
       [_topAssembler addChild:_topAssemblerJaw];
       _topAssembler.position = ccp(winSize.width - 100.0f, winSize.height + 300);
       
       _bottomAssembler = [CCSprite spriteWithFile:@"GameAssembler.png"];
       _bottomAssemblerJaw = [CCSprite spriteWithFile:@"GameAssemblerMouth.png"];
       _bottomAssemblerJaw.position = ccp(_bottomAssemblerJaw.contentSize.width/2 + 17.0f,450.0f);
       [_bottomAssemblerJaw setFlipY:YES];
       [_bottomAssembler addChild:_bottomAssemblerJaw];
       _bottomAssembler.position = ccp(100.0f,-300);
       [_bottomAssembler setFlipY:YES];
       
       [self addChild:background z:Z_BACKGROUND];
       [self addChild:base z:Z_MIDDLE];
       [self addChild:foreground z:Z_FOREGROUND];
       [self addChild:_topAssembler z:Z_ASSEMBLER];
       [self addChild:_bottomAssembler z:Z_ASSEMBLER];
       [self addChild:_topLayer z:Z_COLLISION];
       [self addChild:_bottomLayer z:Z_COLLISION];
       
       [self scheduleUpdate];
       [self loadAnimations];
       
       [_topLayer addRobotToSpawnArray:kRobotColorRed];
       [_topLayer addRobotToSpawnArray:kRobotColorBlue];
       [_topLayer addRobotToSpawnArray:kRobotColorRed];
       
       [_bottomLayer addRobotToSpawnArray:kRobotColorBlue];
       [_bottomLayer addRobotToSpawnArray:kRobotColorRed];
       [_bottomLayer addRobotToSpawnArray:kRobotColorBlue];
    }
    return self;
}

-(void)startTopSpawn
{
   [_topAssembler runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5f position:ccp(0.0f,-400.0f)],
                             [CCCallFunc actionWithTarget:self selector:@selector(topSpawnTwo)], nil]];
}

-(void)topSpawnTwo
{
   [_topLayer spawnRobot];
   [_topAssembler runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.2f position:ccp(0.0f, 40.0f)],[CCDelayTime actionWithDuration:0.5f],[CCMoveBy actionWithDuration:0.2f position:ccp(0.0f,-90.0f)],[CCMoveBy actionWithDuration:0.25f position:ccp(0.0f,450.0f)],[CCCallFunc actionWithTarget:self selector:@selector(finishTopSpawn)], nil]];
   [_topAssemblerJaw runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.2 position:ccp(0.0f, -100)],[CCDelayTime actionWithDuration:0.45f],[CCMoveBy actionWithDuration:0.25f position:ccp(0.0f,100)],nil]];
}

-(void)finishTopSpawn
{
   _topLayer.spawning = NO;
}

-(void)startBottomSpawn
{
   [_bottomAssembler runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.5f position:ccp(0.0f,400.0f)],
                             [CCCallFunc actionWithTarget:self selector:@selector(bottomSpawnTwo)], nil]];
}

-(void)bottomSpawnTwo
{
   [_bottomLayer spawnRobot];
   [_bottomAssembler runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.2f position:ccp(0.0f, -40.0f)],[CCDelayTime actionWithDuration:0.5f],[CCMoveBy actionWithDuration:0.2f position:ccp(0.0f,90.0f)],[CCMoveBy actionWithDuration:0.25f position:ccp(0.0f,-450.0f)],[CCCallFunc actionWithTarget:self selector:@selector(finishBottomSpawn)], nil]];
   [_bottomAssemblerJaw runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.2 position:ccp(0.0f, 100)],[CCDelayTime actionWithDuration:0.45f],[CCMoveBy actionWithDuration:0.25f position:ccp(0.0f,-100)],nil]];
}

-(void)finishBottomSpawn
{
   _bottomLayer.spawning = NO;
}

/*-(void)startSpawn
{
   [_assembler runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.75f position:ccp(_spawnPoint.x,300.0)],[CCCallFunc actionWithTarget:self selector:@selector(spawnTwo)], nil]];
}

-(void)spawnTwo
{
   [_assembler runAction:[CCSequence actions:[CCMoveTo actionWithDuration:0.25f position:ccp(_spawnPoint.x,310.0f)],[CCCallFunc actionWithTarget:self selector:@selector(spawnRobot)],[CCDelayTime actionWithDuration:0.5f],[CCMoveTo actionWithDuration:0.5f position:ccp(_spawnPoint.x,_spawnPoint.y + 500)],nil]];
   [_assemblerMouth runAction:[CCSequence actions:[CCMoveBy actionWithDuration:0.25f position:ccp(0.0f,-100.0f)],[CCDelayTime actionWithDuration:0.5f],[CCMoveBy actionWithDuration:0.25f position:ccp(0.0f,100.0f)], nil]];
}*/


-(void)robotDied:(Robot *)robot onSide:(CollisionLayer *)side
{
   if( side == _topLayer)
   {
      
   }
   else
   {
      
   }
   [side removeChild:robot cleanup:YES];
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
   NSArray* files = [NSArray arrayWithObjects:@"blueWalk", @"redWalk", @"blueDeath", @"redDeath", nil];
   int numFrames[4] = {32,32,38,38};
   NSArray* frameNames = [NSArray arrayWithObjects:@"RoboBlue_000%02d.png", @"RoboRed_000%02d_1.png", @"RoboBlueDeath_%02d.png", @"RoboRedDeath_%02d.png", nil];
   
   for (int i=0; i<[files count]; i++) {
      NSString* file = [files objectAtIndex:i];
      [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist", file]];
      CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"%@.png", file]];
      [self addChild:spriteSheet];
      NSMutableArray *frames = [NSMutableArray array];
      for (int j=0; j<=numFrames[i]; j++) {
         [frames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:[frameNames objectAtIndex:i], j]]];
      }
      
      CCAnimation *anim = [CCAnimation animationWithFrames:frames delay:ANIMATION_DELAY];
      [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:[files objectAtIndex:i]]; 
      
   }
   
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
   CGPoint point = [touch locationInView:[touch view]];
   CGRect rect = CGRectMake(20, 688, 60, 60);
   if (CGRectContainsPoint(rect, point)) {
      NSLog(@"Pause game here");
   }
   
   [_topLayer spawnRobot:kRobotColorBlue];
   [_bottomLayer spawnRobot:kRobotColorRed];
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
