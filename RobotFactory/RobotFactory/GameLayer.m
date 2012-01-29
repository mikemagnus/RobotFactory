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
       
       CCSprite* background = [CCSprite spriteWithFile:@"Background01.png"];
       background.position = ccp(winSize.width / 2, winSize.height/2);
       
       GameObject* base = [GameObject spriteWithFile:@"Belt.png"];
//       base.scaleY = 0.5f;
       
       base.position = ccp(winSize.width / 2, winSize.height / 2);

       base.collisionRect = [base boundingBox];
       
//       [_topLayer addGameObjectToCollision:base];
       
       _assembler = [CCSprite spriteWithFile:@"GameAssembler.png"];
       
       CCSprite* foreground = [CCSprite spriteWithFile:@"Gear-Overlay.png"];
       foreground.position = ccp(winSize.width / 2, winSize.height/2);
       
       [self addChild:background z:Z_BACKGROUND];
       [self addChild:base z:Z_MIDDLE];
       [self addChild:foreground z:Z_FOREGROUND];
       [self addChild:_topLayer z:Z_COLLISION];
       [self addChild:_bottomLayer z:Z_COLLISION];
       
       [self scheduleUpdate];
       [self loadAnimations];
    }
    return self;
}

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
   NSArray* files = [NSArray arrayWithObjects:@"blueWalk", @"redWalk", @"blueDeath", nil];
   int numFrames[3] = {32,32,38};
   NSArray* frameNames = [NSArray arrayWithObjects:@"RoboBlue_000%02d.png", @"RoboRed_000%02d_1.png", @"RoboBlueDeath_%02d.png", nil];
   
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
