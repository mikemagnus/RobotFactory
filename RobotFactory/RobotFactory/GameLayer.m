//
//  GameLayer.m
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import "GameLayer.h"
#import "GameScene.h"


@implementation GameLayer

- (id)init 
{
    if ( (self = [super init]) ) 
    {
        CCLabelTTF *message = [CCLabelTTF labelWithString:@"Game start!" fontName:@"Courier" fontSize:32];
        message.position = ccp(500, 200);
        [self addChild: message];
    }
    return self;
}

+(id) scene
{
    CCScene *scene = [CCScene node];
    GameScene *layer = [GameScene node];
    [scene addChild: layer];
    return scene;
}

-(void)update:(ccTime)dt
{
   
}


-(void) dealloc
{
    [super dealloc];
}


@end
