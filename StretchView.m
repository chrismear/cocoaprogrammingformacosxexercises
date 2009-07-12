//
//  StretchView.m
//  ImageFun
//
//  Created by Chris Mear on 12/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "StretchView.h"


@implementation StretchView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		// Seed the random number generator
		srandom(time(NULL));
		
		// Create a path object
		path = [[NSBezierPath alloc] init];
		[path setLineWidth:3.0];
		NSPoint p = [self randomPoint];
		[path moveToPoint:p];
		int i;
		NSPoint cp1, cp2;
		for (i = 0; i < 15; i++) {
			p = [self randomPoint];
			cp1 = [self randomPoint];
			cp2 = [self randomPoint];
			[path curveToPoint:p controlPoint1:cp1 controlPoint2:cp2];
		}
		[path closePath];
    }
    return self;
}

- (void)dealloc
{
	[path release];
	[super dealloc];
}

// randomPoint returns a random point inside the view
- (NSPoint)randomPoint
{
	NSPoint result;
	NSRect r = [self bounds];
	result.x = r.origin.x + random() % (int)r.size.width;
	result.y = r.origin.y + random() % (int)r.size.height;
	return result;
}

- (void)drawRect:(NSRect)rect {
	NSRect bounds = [self bounds];
	
	// Fill the view with green
	[[NSColor greenColor] set];
	[NSBezierPath fillRect:bounds];
	
	// Draw the path in white
	[[NSColor whiteColor] set];
	[path fill];
}

@end
