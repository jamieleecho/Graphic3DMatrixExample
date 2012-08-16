//
//  JCGraphic3DWindowController.mm
//  Graphic3DMatrixExample
//
//  Created by Jamie Cho on 2010-11-18.
//  Copyright 2010 Jamie Cho. All rights reserved.
//

#import "JCGraphic3DWindowController.h"
#include <Carbon/Carbon.h>

@implementation JCGraphic3DWindowController

-(void)tick:(NSTimer *)timer {
  if (goLeft) {
    camera.thetaY = camera.thetaY - .005;
    [view setNeedsDisplay:YES];
  }
  if (goRight) {
    camera.thetaY = camera.thetaY + .005;
    [view setNeedsDisplay:YES];
  }
  if (goForward) {
    [camera moveX:0 Y:0 Z:5];
    [view setNeedsDisplay:YES];
  }
  if (goBackward) {
    [camera moveX:0 Y:0 Z:-5];
    [view setNeedsDisplay:YES];
  }
}

-(id)init {
  if (self = [super init]) {
  }
  return self;
}

-(void)awakeFromNib {
  [super awakeFromNib];
  [[super window] setPreferredBackingLocation:NSWindowBackingLocationVideoMemory];
  timer = [NSTimer scheduledTimerWithTimeInterval:.01 target:self selector:@selector(tick:) userInfo:nil repeats:YES];
  [self becomeFirstResponder];
}

-(void)dealloc {
  [timer invalidate];
  [super dealloc];
}

-(void)keyDown:(NSEvent*)event {
  unsigned short keyCode = [event keyCode];
  if (keyCode == kVK_LeftArrow) {
    goLeft = YES;
  } else if (keyCode == kVK_RightArrow) {
    goRight = YES;
  } else if (keyCode == kVK_UpArrow) {
    goForward = YES;
  } else if (keyCode == kVK_DownArrow) {
    goBackward = YES;
  }
}

-(void)keyUp:(NSEvent*)event {
  unsigned short keyCode = [event keyCode];
  if (keyCode == kVK_LeftArrow) {
    goLeft = NO;
  } else if (keyCode == kVK_RightArrow) {
    goRight = NO;
  } else if (keyCode == kVK_UpArrow) {
    goForward = NO;
  } else if (keyCode == kVK_DownArrow) {
    goBackward = NO;
  }
}

@end
