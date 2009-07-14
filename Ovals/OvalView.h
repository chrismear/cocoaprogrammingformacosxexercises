//
//  OvalView.h
//  Ovals
//
//  Created by Chris Mear on 14/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface OvalView : NSView {
	NSMutableArray *ovals;
	NSPoint downPoint;
	NSPoint currentPoint;
	BOOL ovalBeingDrawn;
}

@end
