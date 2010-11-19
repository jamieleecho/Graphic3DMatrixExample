//
//  JCObject.m
//  Graphic3DMatrixExample
//
//  Created by Jamie Cho on 2010-11-18.
//  Copyright 2010 Jamie Cho. All rights reserved.
//

#import "JCObject.h"
#import "JCPolygon.h"


@implementation JCObject
@synthesize origin;
@synthesize thetaX;
@synthesize thetaY;

-(id)init {
  if (self = [super init]) {
    origin = jcho::Matrix<double>(4, 1);
    origin.set(1, 0, 5);
    origin.set(3, 0, 1);
  }
  return self;
}

-(void)moveX:(float)x Y:(float)y Z:(float)z {
  jcho::Matrix<double> rot = makeRotationMatrixX(thetaX);
  rot = makeRotationMatrixY(thetaY)  * rot;
  jcho::Matrix<double> p = origin + rot * makePoint(x, y, z);
  p.set(3, 0, 1);
  origin = p;
}

-(jcho::Matrix<double>)perspectiveMatrixForFrame:(NSRect)destFrame nearZ:(float *)nearZ farZ:(float *)farZ {
  jcho::Matrix<double> trans = makeTranslationMatrix(-origin.get(0, 0), -origin.get(1, 0), -origin.get(2, 0));
  jcho::Matrix<double> rot = makeRotationMatrixX(-thetaX);
  rot = makeRotationMatrixY(-thetaY)  * rot;

  *nearZ = 10;
  *farZ = 200;
  return makePerspectiveMatrixZ(destFrame, NSMakeSize(50, 50), *nearZ, *farZ) * rot * trans;
}

@end
