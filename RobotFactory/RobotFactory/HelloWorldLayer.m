//
//  HelloWorldLayer.m
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-27.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//

#import "HelloWorldLayer.h"

@implementation HelloWorldLayer

@synthesize rob = _rob;
@synthesize moveAction = _moveAction;
@synthesize walkAction = _walkAction;

+(CCScene *) scene
{
	CCScene *scene = [CCScene node];
	HelloWorldLayer *layer = [HelloWorldLayer node];
	[scene addChild: layer];
	return scene;
}

-(id) init
{
	if( (self=[super init])) {
        [[CCSpriteFrameCache sharedSpriteFrameCache] addSpriteFramesWithFile:@"roboblue.plist"];
        CCSpriteBatchNode *spriteSheet = [CCSpriteBatchNode batchNodeWithFile:@"roboblue.png"];
        [self addChild:spriteSheet];
        NSMutableArray *walkAnimFrames = [NSMutableArray array];
        for (int i=0; i<=20; i++) {
            [walkAnimFrames addObject: [[CCSpriteFrameCache sharedSpriteFrameCache] spriteFrameByName:[NSString stringWithFormat:@"RoboBlueSmall_000%02d.png", i]]];
        }
        
        CCAnimation *walkAnim = [CCAnimation animationWithFrames:walkAnimFrames delay:0.1f];
        //[[CCAnimationCache sharedAnimationCache] 
        CGSize winSize = [CCDirector sharedDirector].winSize;
        self.rob = [CCSprite spriteWithSpriteFrameName:@"RoboBlueSmall_00000.png"];
        _rob.position = ccp(winSize.width/2, winSize.height/2);
        self.walkAction = [CCRepeatForever actionWithAction:[CCAnimate actionWithAnimation:walkAnim restoreOriginalFrame:NO]];
        [_rob runAction:_walkAction];
        [spriteSheet addChild:_rob];
        
	}
	return self;
}

- (void) dealloc
{
	self.rob = nil;
    self.walkAction = nil;
	[super dealloc];
}
@end
