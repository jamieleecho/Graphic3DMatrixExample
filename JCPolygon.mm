//
//  JCPolygon.mm
//  Graphic3DMatrixExample
//
//  Created by Jamie Cho on 2010-11-17.
//  Copyright 2010 Jamie Cho. All rights reserved.
//

#import "JCPolygon.h"


jcho::Matrix<double> makePoint(double x, double y, double z) {
  jcho::Matrix<double> point(4, 1, jcho::Uninitialized);
  point.set(0, 0, x);
  point.set(1, 0, y);
  point.set(2, 0, z);
  point.set(3, 0, 1);
  return point;
}

jcho::Matrix<double> makeTranslationMatrix(double x, double y, double z) {
  jcho::Matrix<double> matrix(4, 4, jcho::Identity);
  matrix.set(0, 3, x);
  matrix.set(1, 3, y);
  matrix.set(2, 3, z);
  return matrix;
}

jcho::Matrix<double> makePerspectiveMatrixZ(NSRect destFrame, NSSize nearFrame, float nearZ, float farZ) {  
  // Add perspective component
  jcho::Matrix<double> pMatrix(4, 4, jcho::Identity);
  double scaleXZ = nearFrame.width * nearZ;
  double scaleYZ = nearFrame.height * nearZ;
  pMatrix.set(0, 0, scaleXZ);
  pMatrix.set(1, 1, scaleYZ);
  pMatrix.set(2, 2, (nearZ + farZ)/(farZ - nearZ));
  pMatrix.set(2, 3, -(2 * nearZ * farZ)/(farZ - nearZ));
  pMatrix.set(3, 2, 1);
  pMatrix.set(3, 3, 0);
  
  // Scale and translate all points in nearFrame to destFrame
  jcho::Matrix<double> scaleMatrix(4, 4, jcho::Identity);
  scaleMatrix.set(0, 0, destFrame.size.width/nearFrame.width);
  scaleMatrix.set(1, 1, destFrame.size.height/nearFrame.height);
  scaleMatrix.set(0, 3, destFrame.origin.x + destFrame.size.width / 2);
  scaleMatrix.set(1, 3, destFrame.origin.y + destFrame.size.height / 2);
  
  return scaleMatrix * pMatrix;
}

jcho::Matrix<double> makeRotationMatrixX(double theta) {
  jcho::Matrix<double> matrix(4, 4, jcho::Identity);
  double s = sin(theta);
  double c = cos(theta);
  matrix.set(1, 1, c);
  matrix.set(1, 2, -s);
  matrix.set(2, 1, s);
  matrix.set(2, 2, c);
  return matrix;
}

jcho::Matrix<double> makeRotationMatrixY(double theta) {
  jcho::Matrix<double> matrix(4, 4, jcho::Identity);
  double s = sin(theta);
  double c = cos(theta);
  matrix.set(0, 0, c);
  matrix.set(0, 2, s);
  matrix.set(2, 0, -s);
  matrix.set(2, 2, c);
  return matrix;
}

jcho::Matrix<double> makeRotationMatrixZ(double theta) {
  jcho::Matrix<double> matrix(4, 4, jcho::Identity);
  double s = sin(theta);
  double c = cos(theta);
  matrix.set(0, 0, c);
  matrix.set(0, 1, -s);
  matrix.set(1, 0, s);
  matrix.set(1, 1, c);
  return matrix;
}

@implementation JCPolygon 

@synthesize color;

-(id)initWithPoints:(const std::vector<jcho::Matrix<double> > &)thePoints andColor:(NSColor *)theColor {
  if (self = [super init]) {
    points = thePoints;
    self.color = theColor;
  }
  
  return self;
}

-(id)initWithPolygon:(JCPolygon *)polygon andTransform:(const jcho::Matrix<double> &)transform {
  std::vector<jcho::Matrix<double> > thePoints = [polygon points];
  for(std::vector<jcho::Matrix<double> >::iterator it = thePoints.begin(); it!=thePoints.end(); ++it) {
    jcho::Matrix<double> point = *it;
    jcho::Matrix<double> transformedPoint = transform * point;
    *it = transformedPoint;
  }
  return [self initWithPoints:thePoints andColor:polygon.color];
}

-(id)init {
  return [self initWithPoints:std::vector<jcho::Matrix<double> >() andColor:[NSColor greenColor]];
}

-(void)dealloc {
  [color release];
  [super dealloc];
}

-(const std::vector<jcho::Matrix<double> > &)points { return points; }

-(NSString *)description {
  NSMutableString *description = [NSMutableString string];
  [description appendString:@"JCPolygon {\n"];
  for(std::vector<jcho::Matrix<double> >::const_iterator it = points.begin(); it!=points.end(); ++it) {
    [description appendString:@"  "];
    [description appendString:[NSString stringWithUTF8String:(*it).to_string().c_str()]];
    [description appendString:@"\n"];
  }  
  [description appendString:@"}\n"];
  return description;
}

-(BOOL)isBeforeZ:(float)z {
  for(std::vector<jcho::Matrix<double> >::const_iterator it = points.begin(); it!=points.end(); ++it)
    if ((*it).get(2, 0) < z) return NO;
  return YES;
}

- (NSComparisonResult)compare:(id)otherObject {
  JCPolygon *polygon = otherObject;
  if ([polygon points].size() <= 0) return NSOrderedAscending;
  double z0 = [self points][0].get(2, 0);
  double z1 = [polygon points][0].get(2, 0);
  if (z0 == z1) return NSOrderedSame;
  return (z0 < z1) ? NSOrderedDescending : NSOrderedAscending;
}

@end
