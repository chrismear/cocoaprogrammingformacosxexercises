//
//  StretchView.h
//  ImageFun
//
//  Created by Chris Mear on 12/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface StretchView : NSView {
	NSBezierPath *path;
	NSImage *image;
	float opacity;
	NSPoint downPoint;
	NSPoint currentPoint;
	NSTimer *scrollTimer;
}

@property (readwrite) float opacity;

- (void) setImage:(NSImage *)newImage;
- (NSPoint)randomPoint;
- (NSRect)currentRect;

@end
