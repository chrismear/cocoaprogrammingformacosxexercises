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
}

- (NSPoint)randomPoint;

@end
