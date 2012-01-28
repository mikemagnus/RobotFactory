//
//  GameLayer.h
//  Robot_Factory
//
//  Created by Michael Magnus on 12-01-27.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"

@interface GameLayer : CCLayer 
{
   CCArray*   _actors;
   CCArray*   _obstacles;
}

@end
