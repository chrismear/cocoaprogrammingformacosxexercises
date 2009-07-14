//
//  Oval.m
//  Ovals
//
//  Created by Chris Mear on 14/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import "Oval.h"


@implementation Oval

- (id)init
{
	return [self initWithRect:NSMakeRect(0, 0, 0, 0)];
}

- (id)initWithRect:(NSRect)newRect
{
	if (![super init])
		return nil;
	
	rect = newRect;
	return self;
}

- (NSRect)rect
{
	return rect;
}

- (void)setRect:(NSRect)newRect
{
	rect = newRect;
}

- (void)encodeWithCoder:(NSCoder *)coder
{
	[coder encodeFloat:(rect.origin.x) forKey:@"x"];
	[coder encodeFloat:(rect.origin.y) forKey:@"y"];
	[coder encodeFloat:(rect.size.width) forKey:@"width"];
	[coder encodeFloat:(rect.size.height) forKey:@"height"];
}

- (id)initWithCoder:(NSCoder *)coder
{
	[super init];
	CGFloat x, y, w, h;
	x = [coder decodeFloatForKey:@"x"];
	y = [coder decodeFloatForKey:@"y"];
	w = [coder decodeFloatForKey:@"width"];
	h = [coder decodeFloatForKey:@"height"];
	rect = NSMakeRect(x, y, w, h);
	return self;
}

@end
