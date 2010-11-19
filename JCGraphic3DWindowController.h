//
//  JCGraphic3DWindowController.h
//  Graphic3DMatrixExample
//
//  Created by Jamie Cho on 2010-11-18.
//  Copyright 2010 Jamie Cho. All rights reserved.
//

#import <Cocoa/Cocoa.h>
#import "JCWorldView.h"
#import "JCObject.h"

@interface JCGraphic3DWindowController : NSWindowController {
  IBOutlet JCWorldView *view;
  IBOutlet JCObject *camera;
  @private NSTimer *timer;
  @private BOOL goLeft;
  @private BOOL goRight;
  @private BOOL goForward;
  @private BOOL goBackward;
}

@end
