//
//  HelloWorldLayer.h
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-27.
//  Copyright __MyCompanyName__ 2012. All rights reserved.
//


// When you import this file, you import all the cocos2d classes
#import "cocos2d.h"

// HelloWorldLayer
@interface HelloWorldLayer : CCLayer
{
    CCSprite *_rob;
    CCAction *_walkAction;
    CCAction *_moveAction;
    BOOL _moving;
}

@property (nonatomic, retain) CCSprite *rob;
@property (nonatomic, retain) CCAction *walkAction;
@property (nonatomic, retain) CCAction *moveAction;

// returns a CCScene that contains the HelloWorldLayer as the only child
+(CCScene *) scene;

@end
