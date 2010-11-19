//
//  JCWorld.h
//  Graphic3DMatrixExample
//
//  Created by Jamie Cho on 2010-11-17.
//  Copyright 2010 Jamie Cho. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "JCPolygonSet.h"

@interface JCWorld : NSObject {
  NSMutableSet *randomObjects;
}

@property(readwrite, retain) NSMutableSet *randomObjects;

@end
