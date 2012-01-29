//
//  GameLayer.m
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "SimpleAudioEngine.h"
#import "GameLayer.h"
#import "GameObject.h"
#import "Obstacle.h"
#import "MainMenuScene.h"
#import "LevelSelectScene.h"
#import "Wall.h"

@implementation GameLayer

+(id) sceneWithIndex:(int)level
{
   CCScene *scene = [CCScene node];
   GameLayer *layer = [[[GameLayer alloc] initWithIndex:level] autorelease];
   [scene addChild: layer];
   return scene;
}

- (id)initWithIndex:(int)level
{
    if ( (self = [super init]) ) 
    {
        /*CCLabelTTF *message = [CCLabelTTF labelWithString:@"Game start!" fontName:@"Courier" fontSize:32];
        message.position = ccp(500, 200);
        [self addChild: message];*/
       CGSize winSize = [[CCDirector sharedDirector] winSize];
       
       levelIndex = level;
       
       self.isTouchEnabled = YES;
       
       _topLayer = [[CollisionLayer alloc] init];
       _topLayer.position = ccp(0.0f,winSize.height / 2);
       [_topLayer setDelegate:self andSelector:@selector(startTopSpawn)];
       
       _bottomLayer = [[CollisionLayer alloc] init];
       _bottomLayer.position = ccp(0.0f,-(winSize.height / 2));
       [_bottomLayer setDelegate:self andSelector:@selector(startBottomSpawn)];
       _bottomLayer.rotation = 180.0f;
       
       CCSprite* background = [CCSprite spriteWithFile:[NSString stringWithFormat:@"Level-Backgroun0%d.png",level]];
       background.position = ccp(winSize.width / 2, winSize.height/2);
       
       GameObject* base = [GameObject spriteWithFile:@"Belt.png"];
//       base.scaleY = 0.5f;
       
       base.position = ccp(winSize.width / 2, winSize.height / 2 - 1);

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
       
       /*[_topLayer addRobotToSpawnArray:kRobotColorBlue];
       //[_topLayer addRobotToSpawnArray:kRobotColorBlue];
       //[_topLayer addRobotToSpawnArray:kRobotColorRed];
       
       [_bottomLayer addRobotToSpawnArray:kRobotColorRed];
       //[_bottomLayer addRobotToSpawnArray:kRobotColorRed];
       //[_bottomLayer addRobotToSpawnArray:kRobotColorBlue];
       
       Obstacle* ob = [Obstacle spriteWithSpriteFrameName:@"GameTeslaCoil1.png"];
       ob.position = ccp(winSize.width/2,-37 + 120);
//       ob.collisionRect = ob.boundingBox;
       Obstacle* ob2 = [Obstacle spriteWithSpriteFrameName:@"GameTeslaCoil1.png"];
       ob2.position = ccp(winSize.width/2,-37 + 120);
       
       ob.buddy = ob2;
       ob2.buddy = ob;
       ob.isActive = YES;
       ob2.isActive = NO;
       [_topLayer addObstacleToCollision:ob];
       [_topLayer addChild:ob z:1];
       [_bottomLayer addObstacleToCollision:ob2];
       [_bottomLayer addChild:ob2 z:1];
       
       Wall* wall = [Wall spriteWithSpriteFrameName:@"GameWall1.png"];
       wall.position = ccp(winSize.width/2 + 100, -37 + 120);
       Wall* wall2 = [Wall spriteWithSpriteFrameName:@"GameWall2.png"];
       wall2.position = ccp(winSize.width/2 + 100, -37 + 120);
       
       wall.buddy = wall2;
       wall2.buddy = wall;
       wall.isActive = NO;
       wall2.isActive = YES;
       
       [_topLayer addWallToCollision:wall];
       [_topLayer addChild:wall z:1];
       [_bottomLayer addWallToCollision:wall2];
       [_bottomLayer addChild:wall2 z:1];*/
       
       [self setupLevel:level];
       
       [[SimpleAudioEngine sharedEngine] playBackgroundMusic:@"Robobo_ingame_music.caf" loop:YES];
       
       //Pause button
       
       gamePaused = NO;
       
       pauseButton = [CCMenuItemImage itemFromNormalImage:@"Pause-static.png" selectedImage:@"Pause-pressed.png" target:self selector:@selector(pauseGame:)];
       
       CCMenu *menu = [CCMenu menuWithItems:pauseButton, nil];
       menu.position = ccp(winSize.width-40, 40);
       
       [self addChild:menu z:Z_FOREGROUND];
       
    }
    return self;
}

-(void)addTeslaTopPosition:(CGPoint)topPos bottomPosition:(CGPoint)botPos topActive:(BOOL)ta
{
   Obstacle* ob = [Obstacle spriteWithSpriteFrameName:@"GameTeslaCoil1.png"];
   ob.position = topPos;
   //       ob.collisionRect = ob.boundingBox;
   Obstacle* ob2 = [Obstacle spriteWithSpriteFrameName:@"GameTeslaCoil1.png"];
   ob2.position = botPos;
   
   ob.buddy = ob2;
   ob2.buddy = ob;
   if(ta)
   {
      ob.isActive = YES;
      ob2.isActive = NO;
   }
   else
   {
      ob.isActive = NO;
      ob2.isActive = YES;
   }
   [_topLayer addObstacleToCollision:ob];
   [_topLayer addChild:ob z:1];
   [_bottomLayer addObstacleToCollision:ob2];
   [_bottomLayer addChild:ob2 z:1];
}

-(void)addWallTopPosition:(CGPoint)topPos bottomPosition:(CGPoint)botPos topActive:(BOOL)ta
{
   Wall* wall = [Wall spriteWithSpriteFrameName:@"GameWall1.png"];
   wall.position = topPos;
   Wall* wall2 = [Wall spriteWithSpriteFrameName:@"GameWall1.png"];
   wall2.position = botPos;
   
   wall.buddy = wall2;
   wall2.buddy = wall;
   
   if(ta)
   {
      wall.isActive = YES;
      wall2.isActive = NO;
   }
   else
   {
      wall.isActive = NO;
      wall2.isActive = YES;
   }
   
   [_topLayer addWallToCollision:wall];
   [_topLayer addChild:wall z:1];
   [_bottomLayer addWallToCollision:wall2];
   [_bottomLayer addChild:wall2 z:1];
}

-(void)setupLevel:(int)level
{
   switch (level) 
   {
      case 1:
         [self addTeslaTopPosition:ccp(506,98) bottomPosition:ccp(518,98) topActive:YES];
         [self addWallTopPosition:ccp(300,98) bottomPosition:ccp(724,98) topActive:NO];
         [_topLayer addRobotToSpawnArray:kRobotColorBlue];
         [_bottomLayer addRobotToSpawnArray:kRobotColorRed];
         break;
      case 2:
         [self addTeslaTopPosition:ccp(506,98) bottomPosition:ccp(518,98) topActive:YES];
         [self addWallTopPosition:ccp(350,98) bottomPosition:ccp(674,98) topActive:NO];
         [self addWallTopPosition:ccp(674,98) bottomPosition:ccp(350,98) topActive:YES];
         [_topLayer addRobotToSpawnArray:kRobotColorBlue];
         [_topLayer addRobotToSpawnArray:kRobotColorRed];
         [_bottomLayer addRobotToSpawnArray:kRobotColorBlue];
         break;
      case 3:
         [self addTeslaTopPosition:ccp(506,98) bottomPosition:ccp(518,98) topActive:YES];
         [_topLayer addRobotToSpawnArray:kRobotColorRed];
         [_topLayer addRobotToSpawnArray:kRobotColorBlue];
         [_bottomLayer addRobotToSpawnArray:kRobotColorBlue];
         [_bottomLayer addRobotToSpawnArray:kRobotColorRed];
         break;
      default:
         break;
   }
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


-(void)robotDied:(Robot *)robot
{
   if( robot.parent == _topLayer)
   {
      [_bottomLayer addRobotToSpawnArray:robot.robColor];
      [_topLayer removeRobot:robot];
   }
   else
   {
      [_topLayer addRobotToSpawnArray:robot.robColor];
      [_bottomLayer removeRobot:robot];
   }
   [robot removeFromParentAndCleanup:YES];
}



-(void)registerWithTouchDispatcher
{
    [[CCTouchDispatcher sharedDispatcher] addTargetedDelegate:self priority:1 swallowsTouches:NO];
}

-(void)update:(ccTime)dt
{
   [_topLayer update:dt];
   [_bottomLayer update:dt];
   if ([_topLayer spawnQueueEmpty] && [_bottomLayer spawnQueueEmpty] && [_topLayer allSameColor:kRobotColorRed] && [_bottomLayer allSameColor:kRobotColorBlue]) {
      [self unscheduleUpdate];
      [_topLayer winGame];
      [_bottomLayer winGame];
      [[SimpleAudioEngine sharedEngine] stopBackgroundMusic];
      [[SimpleAudioEngine sharedEngine] playEffect:@"RobotVictory.mp3" pitch:1 pan:1 gain:3];
      [self runAction:[CCSequence actions:[CCDelayTime actionWithDuration:2.0f],[CCCallFunc actionWithTarget:self selector:@selector(winGame)],nil]];
   }
}

-(void)winGame
{

   
   pauseButton.visible = NO;
//   [self unscheduleUpdate];
   
   CGSize winSize = [[CCDirector sharedDirector] winSize];
   CCSprite* winOverlay = [CCSprite spriteWithFile:@"Complete-Overlay.png"];
   winOverlay.position = ccp(winSize.width/2, winSize.height/2);
   
   [self addChild:winOverlay z:Z_FOREGROUND];
}

-(void)pauseGame: (id) sender
{
   if (!gamePaused) {
      
      gamePaused = YES;
      pauseButton.visible = NO;
      
      [[CCDirector sharedDirector] pause];
      
      CGSize winSize = [[CCDirector sharedDirector] winSize];
      
      pauseOverlay = [CCSprite spriteWithFile:@"Paused-overlay.png"];
      pauseOverlay.position = ccp(winSize.width/2, winSize.height/2);
      
      
      CCMenuItemImage *resumeButton = [CCMenuItemImage itemFromNormalImage:@"ButtonResume.png" selectedImage:@"ButtonResumePressed.png" target:self selector:@selector(resumeGame:)];
      resumeButton.scale = 0.5;
      CCMenuItemImage *menuButton = [CCMenuItemImage itemFromNormalImage:@"ButtonMainMenu.png" selectedImage:@"ButtonMainMenuPressed.png" target:self selector:@selector(goToMenu:)];
      menuButton.scale = 0.5;
      
      CCMenu *pauseMenu = [CCMenu menuWithItems:resumeButton, menuButton, nil];
      [pauseMenu alignItemsVerticallyWithPadding:20];
      pauseMenu.position = ccp(winSize.width/2, 200);
      
      [self addChild:pauseOverlay z:Z_FOREGROUND];
      [pauseOverlay addChild:pauseMenu z:Z_FOREGROUND];
   }
}

-(void)resumeGame: (id) sender
{
   if (gamePaused) {
      
      gamePaused = NO;
      pauseButton.visible = TRUE;
      
      [[CCDirector sharedDirector] resume];
      [self removeChild:pauseOverlay cleanup:YES];
   }
}

-(void)goToMenu: (id) sender
{
   [[CCDirector sharedDirector] resume];
   gamePaused = NO;
   [[CCDirector sharedDirector] replaceScene:[MainMenuScene scene]];
}

#define ANIMATION_DELAY 1/30.0f

-(void)loadAnimations
{
   NSArray* files = [NSArray arrayWithObjects:@"blueWalk", @"redWalk", @"blueDeath", @"redDeath",@"TeslaCoil_default",@"GameWall_default", nil];
   int numFrames[6] = {32,32,38,38,3,2};
   NSArray* frameNames = [NSArray arrayWithObjects:@"RoboBlue_000%02d.png", @"RoboRed_000%02d_1.png", @"RoboBlueDeath_%02d.png", @"RoboRedDeath_%02d.png",@"GameTeslaCoil%d.png",@"GameWall%d.png", nil];
   
   for (int i=0; i<[files count]; i++) {
      NSString* file = [files objectAtIndex:i];
      [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist", file]];
      CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"%@.png", file]];
      [self addChild:spriteSheet];
      NSMutableArray *frames = [NSMutableArray array];
      for (int j=0; j<=numFrames[i]; j++) {
         if(i < 4)
            [frames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:[frameNames objectAtIndex:i], j]]];
         else
            [frames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:[frameNames objectAtIndex:i], j + 1]]];
      }
      
      CCAnimation *anim = [CCAnimation animationWithFrames:frames delay:ANIMATION_DELAY];
      [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:[files objectAtIndex:i]]; 
      
   }
   [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist", @"roboredWin"]];
   [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:[NSString stringWithFormat:@"%@.plist", @"roboblueWin"]];
   CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"%@.png",@"roboredWin"]];
   CCSpriteBatchNode *spriteSheet2 = [CCSpriteBatchNode batchNodeWithFile:[NSString stringWithFormat:@"%@.png",@"roboblueWin"]];
   [self addChild:spriteSheet];
   [self addChild:spriteSheet2];
   
   NSMutableArray *frames = [NSMutableArray array];
   NSMutableArray *frames2 = [NSMutableArray array];
   for (int j=0; j<28; j++) {
      [frames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"RoboRedWin_%02d.png", j]]];
      [frames2 addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"RoboBlueWin_%02d.png", j]]];
   }
   for (int i=0; i<3;i++)
   {
      for (int j=28; j<=40;j++)
      {
         [frames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"RoboRedWin_%02d.png", j]]];
         [frames2 addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"RoboBlueWin_%02d.png", j]]];
      }
   }
   CCAnimation *anim = [CCAnimation animationWithFrames:frames delay:ANIMATION_DELAY];
   CCAnimation *anim2 = [CCAnimation animationWithFrames:frames2 delay:ANIMATION_DELAY];
   [[CCAnimationCache sharedAnimationCache] addAnimation:anim name:@"roboredWin"]; 
   [[CCAnimationCache sharedAnimationCache] addAnimation:anim2 name:@"roboblueWin"];
   
}

-(BOOL)ccTouchBegan:(UITouch *)touch withEvent:(UIEvent *)event
{
   CGPoint point = [touch locationInView:[touch view]];
   CGRect rect = CGRectMake(20, 688, 60, 60);
   if (CGRectContainsPoint(rect, point)) {
      NSLog(@"Pause game here");
      return YES;
   }
   
//   [_topLayer spawnRobot:kRobotColorBlue];
//   [_bottomLayer spawnRobot:kRobotColorRed];
   return NO;
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
