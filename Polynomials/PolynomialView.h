//
//  PolynomialView.h
//  Polynomials
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface PolynomialView : NSView {
	NSMutableArray *polynomials;
}
- (IBAction)createNewPolynomial:(id)sender;
- (IBAction)deleteRandomPolynomial:(id)sender;
@end
