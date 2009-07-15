//
//  Polynomial.h
//  Polynomials
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Polynomial : NSObject {
	__strong CGFloat * terms;
	int termCount;
	__strong CGColorRef color;
}

- (float)valueAt:(float)x;
- (void)drawInRect:(CGRect)b
		 inContext:(CGContextRef)ctx;
- (CGColorRef)color;

@end
