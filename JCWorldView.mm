//
//  JCWorldView.m
//  Graphic3DMatrixExample
//
//  Created by Jamie Cho on 2010-11-17.
//  Copyright 2010 Jamie Cho. All rights reserved.
//

#import "JCWorldView.h"

@implementation JCWorldView

@synthesize world;
@synthesize camera;

- (void)drawRect:(NSRect)dirtyRect {
  NSRect rect = [self bounds];
  
  // Draw the sky
  [[NSColor colorWithCalibratedRed:.9 green:.9 blue:1 alpha:1] setFill];
  [[NSBezierPath bezierPathWithRect:rect] fill];
  
  // Compute the tranformation that maps objects to this view
  float nearZ, farZ;
  jcho::Matrix<double> transform = [camera perspectiveMatrixForFrame:rect nearZ:&nearZ farZ:&farZ];

  // Apply the transforms
  NSMutableArray *polygons = [NSMutableArray array];
  for(JCPolygonSet *polygonSet in world.randomObjects) {
    JCPolygonSet *transformedPolygonSet = [[[JCPolygonSet alloc] initWithPolygonSet:polygonSet andTransform:transform] autorelease];
    for(JCPolygon *polygon in transformedPolygonSet.polygons) {
      [polygons addObject:polygon];
    }
  }
  
  // Make sure we render the farthest polygons first
  [polygons sortUsingSelector:@selector(compare:)];
  
  // Render the transforms
  for(JCPolygon *polygon in polygons) {
    if (![polygon isBeforeZ:nearZ]) continue;
    NSBezierPath *path = [[NSBezierPath alloc] init];
    const std::vector<jcho::Matrix<double> > &points = [polygon points];
    for(std::vector<jcho::Matrix<double> >::const_iterator it = points.begin(); it != points.end(); it++) {
      const jcho::Matrix<double> p = (*it);
      float wz = (float)p.get(3, 0);
      NSPoint point = NSMakePoint(p.get(0, 0)/wz, p.get(1, 0)/wz);
      if (it == points.begin()) {
        [path moveToPoint:point];
      } else {
        [path lineToPoint:point];
      }
    }
    [path closePath];      
    [[polygon color] setFill];
    [path fill];
    [path release];
  }
}

@end
