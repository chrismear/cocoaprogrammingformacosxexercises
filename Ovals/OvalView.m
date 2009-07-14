//
//  OvalView.m
//  Ovals
//
//  Created by Chris Mear on 14/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "OvalView.h"


@implementation OvalView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        ovals = [[NSMutableArray alloc] initWithCapacity:10];
		ovalBeingDrawn = NO;
    }
    return self;
}

- (NSRect)currentRect
{
	float minX = MIN(downPoint.x, currentPoint.x);
	float maxX = MAX(downPoint.x, currentPoint.x);
	float minY = MIN(downPoint.y, currentPoint.y);
	float maxY = MAX(downPoint.y, currentPoint.y);
	
	return NSMakeRect(minX, minY, maxX-minX, maxY-minY);
}

- (void)drawRect:(NSRect)rect {
	[[NSColor greenColor] set];
	
	// Draw the existing ovals
	NSValue *ovalRectValue;
	NSRect ovalRect;
	NSBezierPath *ovalPath;
	for (ovalRectValue in ovals) {
		ovalRect = [ovalRectValue rectValue];
		ovalPath = [NSBezierPath bezierPathWithOvalInRect:ovalRect];
		[ovalPath fill];
	}
	
	// Draw the oval in the process of being specified
	if (ovalBeingDrawn) {
		ovalRect = [self currentRect];
		ovalPath = [NSBezierPath bezierPathWithOvalInRect:ovalRect];
		[ovalPath fill];
	}
}

- (void)mouseDown:(NSEvent *)event
{
	NSPoint p = [event locationInWindow];
	downPoint = [self convertPoint:p fromView:nil];
	currentPoint = downPoint;
	
	ovalBeingDrawn = YES;
	
	[self setNeedsDisplay:YES];
}

- (void)mouseDragged:(NSEvent *)event
{
	NSPoint p = [event locationInWindow];
	currentPoint = [self convertPoint:p fromView:nil];
	[self setNeedsDisplay:YES];
}

- (void)mouseUp:(NSEvent *)event
{
	NSPoint p = [event locationInWindow];
	currentPoint = [self convertPoint:p fromView:nil];
	NSRect newOvalRect = [self currentRect];
	NSValue *newOvalRectValue = [NSValue valueWithRect:newOvalRect];
	[ovals addObject:newOvalRectValue];
	
	ovalBeingDrawn = NO;
	
	[self setNeedsDisplay:YES];	
}

@end
