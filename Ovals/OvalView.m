//
//  OvalView.m
//  Ovals
//
//  Created by Chris Mear on 14/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "OvalView.h"
#import "Oval.h"

@implementation OvalView

- (id)initWithFrame:(NSRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
		ovalBeingDrawn = NO;
    }
    return self;
}

- (id)dataSource
{
	return dataSource;
}

- (void)setDataSource:(id)newDataSource
{
	dataSource = newDataSource;
}

- (NSMutableArray *)ovals
{
	if([dataSource respondsToSelector:@selector(ovals)]) {
		return [dataSource ovals];
	} else {
		[NSException raise:NSInternalInconsistencyException format:@"dataSource doesn't respond to ovals"];
		NSMutableArray *emptyOvals = [[NSMutableArray alloc] init];
		[emptyOvals autorelease];
		return emptyOvals;
	}
}

- (void)createOval:(Oval *)newOval
{
	if([dataSource respondsToSelector:@selector(createOval:)]) {
		[dataSource createOval:newOval];
	} else {
		[NSException raise:NSInternalInconsistencyException format:@"dataSource doesn't respond to createOval:"];
	}
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
	NSMutableArray *ovals = [self ovals];
	Oval *oval;
	NSBezierPath *ovalPath;
	for (oval in ovals) {
		ovalPath = [NSBezierPath bezierPathWithOvalInRect:[oval rect]];
		[ovalPath fill];
	}
	
	// Draw the oval in the process of being specified
	if (ovalBeingDrawn) {
		NSRect ovalRect = [self currentRect];
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
	Oval *newOval = [[Oval alloc] initWithRect:newOvalRect];
	[self createOval:newOval];
	[newOval release];
	
	ovalBeingDrawn = NO;
	
	[self setNeedsDisplay:YES];	
}

@end
