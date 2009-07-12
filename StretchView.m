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
        // Initialization code here.
    }
    return self;
}

- (void)drawRect:(NSRect)rect {
	NSRect bounds = [self bounds];
	[[NSColor greenColor] set];
	[NSBezierPath fillRect:bounds];
}

@end
