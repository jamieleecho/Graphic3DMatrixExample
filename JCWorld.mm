//
//  JCWorld.m
//  Graphic3DMatrixExample
//
//  Created by Jamie Cho on 2010-11-17.
//  Copyright 2010 Jamie Cho. All rights reserved.
//

#import "JCWorld.h"


@implementation JCWorld
@synthesize randomObjects;

-(id) init {
  self = [super init];
  if (self) {
    randomObjects = [[NSMutableSet alloc] init];    
    BOOL speedSign = YES;
    for(double theta=0; theta < 8*M_PI; theta += 2*M_PI/25) {
      double xx = 2 * sin(3 * theta);
      double zz = theta * 500;
      JCPolygonSet *polys = speedSign ? [JCPolygonSet speedSignPolygonSet] : [JCPolygonSet warningSignPolygonSet];      
      speedSign = !speedSign;      
      jcho::Matrix<double> transform1 = makeTranslationMatrix(xx - 10, 0, zz);
      jcho::Matrix<double> transform2 = makeTranslationMatrix(xx + 10, 0, zz);
      [randomObjects addObject:[[[JCPolygonSet alloc] initWithPolygonSet:polys andTransform:transform1] autorelease]];
      [randomObjects addObject:[[[JCPolygonSet alloc] initWithPolygonSet:polys andTransform:transform2] autorelease]];
    }
  }
  return self;
}

-(void) dealloc {
  [randomObjects release];
  [super dealloc];
}

@end
