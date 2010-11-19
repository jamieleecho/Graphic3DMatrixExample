//
//  JCObject.h
//  Graphic3DMatrixExample
//
//  Created by Jamie Cho on 2010-11-18.
//  Copyright 2010 Jamie Cho. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include "Matrix.h"

@interface JCObject : NSWindowController {
  @private jcho::Matrix<double> origin;
  @private float thetaX;
  @private float thetaY;
}

@property(readwrite, assign) jcho::Matrix<double> origin;
@property(readwrite, assign) float thetaX;
@property(readwrite, assign) float thetaY;

-(void)moveX:(float)x Y:(float)y Z:(float)z;

-(jcho::Matrix<double>)perspectiveMatrixForFrame:(NSRect)destFrame nearZ:(float *)nearZ farZ:(float *)farZ;

@end
