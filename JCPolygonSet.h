//
//  JCPolygonSet.h
//  Graphic3DMatrixExample
//
//  Created by Jamie Cho on 2010-11-17.
//  Copyright 2010 Jamie Cho. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JCPolygon.h"

@interface JCPolygonSet : NSObject {
  @private NSMutableSet *polygons;
}

@property(readonly, retain) NSMutableSet *polygons;

+(JCPolygonSet *)speedSignPolygonSet;
+(JCPolygonSet *)warningSignPolygonSet;

-(id)initWithPolygonSet:(JCPolygonSet *)polygonSet andTransform:(const jcho::Matrix<double> &)transform;

@end
