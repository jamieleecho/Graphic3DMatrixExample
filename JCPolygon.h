//
//  JCPolygon.h
//  Graphic3DMatrixExample
//
//  Created by Jamie Cho on 2010-11-17.
//  Copyright 2010 Jamie Cho. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#include <vector>
#include "Matrix.h"

jcho::Matrix<double> makePoint(double x, double y, double z);
jcho::Matrix<double> makeTranslationMatrix(double x, double y, double z);
jcho::Matrix<double> makePerspectiveMatrixZ(NSRect destFrame, NSSize nearFrame, float nearZ, float farZ);
jcho::Matrix<double> makeRotationMatrixX(double theta);
jcho::Matrix<double> makeRotationMatrixY(double theta);
jcho::Matrix<double> makeRotationMatrixZ(double theta);

@interface JCPolygon : NSObject {
  @private std::vector<jcho::Matrix<double> > points;
  @private NSColor *color;
}

@property(readwrite, retain) NSColor *color;

-(id)initWithPoints:(const std::vector<jcho::Matrix<double> > &)thePoints andColor:(NSColor *)theColor;
-(id)initWithPolygon:(JCPolygon *)polygon andTransform:(const jcho::Matrix<double> &)transform;
-(const std::vector<jcho::Matrix<double> > &)points;
-(BOOL)isBeforeZ:(float)z;

@end
