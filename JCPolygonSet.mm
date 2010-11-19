//
//  JCPolygonSet.m
//  Graphic3DMatrixExample
//
//  Created by Jamie Cho on 2010-11-17.
//  Copyright 2010 Jamie Cho. All rights reserved.
//

#import "JCPolygonSet.h"

@implementation JCPolygonSet
@synthesize polygons;

+(JCPolygonSet *)speedSignPolygonSet {
  JCPolygonSet *polygons = [[[JCPolygonSet alloc] init] autorelease];
  
  // Model the post
  std::vector<jcho::Matrix<double> > postPoints;
  postPoints.push_back(makePoint(-.25, 0, 0));
  postPoints.push_back(makePoint(.25, 0, 0));
  postPoints.push_back(makePoint(.25, 5, 0));
  postPoints.push_back(makePoint(-.25, 5, 0));  
  JCPolygon *post = [[[JCPolygon alloc] initWithPoints:postPoints andColor:[NSColor grayColor]] autorelease];
  [polygons.polygons addObject:post];
  
  // Model the sign
  std::vector<jcho::Matrix<double> > signPoints;  
  signPoints.push_back(makePoint(-1, 5, 0));
  signPoints.push_back(makePoint(1, 5, 0));
  signPoints.push_back(makePoint(1, 8, 0));
  signPoints.push_back(makePoint(-1, 8, 0));
  JCPolygon *sign = [[[JCPolygon alloc] initWithPoints:signPoints andColor:[NSColor whiteColor]] autorelease];
  [polygons.polygons addObject:sign];

  return polygons;  
}

+(JCPolygonSet *)warningSignPolygonSet {
  JCPolygonSet *polygons = [[[JCPolygonSet alloc] init] autorelease];

  // Model the post
  std::vector<jcho::Matrix<double> > postPoints;
  postPoints.push_back(makePoint(-.25, 0, 0));
  postPoints.push_back(makePoint(.25, 0, 0));
  postPoints.push_back(makePoint(.25, 5, 0));
  postPoints.push_back(makePoint(-.25, 5, 0));  
  JCPolygon *post = [[[JCPolygon alloc] initWithPoints:postPoints andColor:[NSColor grayColor]] autorelease];
  [polygons.polygons addObject:post];
  
  // Model the sign
  std::vector<jcho::Matrix<double> > signPoints;  
  signPoints.push_back(makePoint(0, 9, 0));
  signPoints.push_back(makePoint(-1.5, 5 , 0));
  signPoints.push_back(makePoint(1.5, 5, 0));
  JCPolygon *sign = [[[JCPolygon alloc] initWithPoints:signPoints andColor:[NSColor yellowColor]] autorelease];
  [polygons.polygons addObject:sign];

  return polygons;  
}


-(id)init {
  if (self = [super init]) {
    polygons = [[NSMutableSet alloc] init];
  }
  return self;
}


-(id)initWithPolygonSet:(JCPolygonSet *)polygonSet andTransform:(const jcho::Matrix<double> &)transform {
  if (self = [self init]) {
    for(JCPolygon *polygon in polygonSet.polygons)
      [polygons addObject:[[[JCPolygon alloc] initWithPolygon:polygon andTransform:transform] autorelease]];
  }
  return self;  
}


-(void)dealloc {
  [polygons release];
  [super dealloc];
}


-(NSString *)description {
  NSMutableString *description = [NSMutableString string];
  [description appendString:@"JCPolygonSet {\n"];
  for(JCPolygon *polygon in polygons) {
    [description appendString:[polygon description]];
  }
  [description appendString:@"}\n"];
  return description;
}

@end
