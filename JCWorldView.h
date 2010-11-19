//
//  JCWorldView.h
//  Graphic3DMatrixExample
//
//  Created by Jamie Cho on 2010-11-17.
//  Copyright 2010 Jamie Cho. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JCWorld.h"
#import "JCObject.h"

@interface JCWorldView : NSView {
  IBOutlet JCObject *camera;
  IBOutlet JCWorld *world;
}

@property(readwrite, retain) JCWorld *world;
@property(readwrite, retain) JCObject *camera;

@end
