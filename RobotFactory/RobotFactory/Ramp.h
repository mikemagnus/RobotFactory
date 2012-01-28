//
//  Ramp.h
//  RobotFactory
//
//  Created by Michael Magnus on 12-01-28.
//  Copyright 2012 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "cocos2d.h"
#import "GameObject.h"



@interface Ramp : GameObject 
{
   CGPoint _p1;
   CGPoint _p2;
   CGPoint _p3;
   CGPoint _p4;
   
   CGPoint _ps;
   CGPoint _pe;
}

@end
