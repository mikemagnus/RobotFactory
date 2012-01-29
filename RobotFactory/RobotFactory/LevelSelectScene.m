//
//  LevelSelectScene.m
//  RobotFactory
//
//  Created by Christopher Lee on 12-01-29.
//  Copyright (c) 2012 __MyCompanyName__. All rights reserved.
//

#import "LevelSelectScene.h"

@implementation LevelSelectScene

+(id) scene
{
   CCScene *scene = [CCScene node];
   LevelSelectScene *layer = [LevelSelectScene node];
   [scene addChild: layer];
   return scene;
}

-(id) init
{
   if ((self = [super init])) {
      
   }
}

@end
