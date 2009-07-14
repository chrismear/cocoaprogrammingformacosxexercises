//
//  OvalView.h
//  Ovals
//
//  Created by Chris Mear on 14/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class Oval;

@interface OvalView : NSView {
	IBOutlet id dataSource;
	
	NSPoint downPoint;
	NSPoint currentPoint;
	BOOL ovalBeingDrawn;
}

- (id)dataSource;
- (void)setDataSource:(id)newDataSource;

@end

@interface NSObject (OvalViewDelegate)

- (NSMutableArray *)ovals;
- (void)createOval:(Oval *)newOval;

@end;