//
//  Oval.h
//  Ovals
//
//  Created by Chris Mear on 14/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Oval : NSObject {
	NSRect rect;
}
- (id)init;
- (id)initWithRect:(NSRect)newRect;
- (NSRect)rect;
- (void)setRect:(NSRect)newRect;
@end
