//
//  MyDocument.h
//  Ovals
//
//  Created by Chris Mear on 14/07/2009.
//  Copyright Greenvoice 2009 . All rights reserved.
//


#import <Cocoa/Cocoa.h>
@class Oval;

@interface MyDocument : NSDocument
{
	NSMutableArray *ovals;
}
- (NSMutableArray *)ovals;
- (void)setOvals:(NSMutableArray *)newOvals;
- (void)createOval:(Oval *)newOval;
@end
