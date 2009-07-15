//
//  BigLetterView.h
//  TypingTutor
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface BigLetterView : NSView {
	NSColor *bgColor;
	NSString *string;
	NSMutableDictionary *attributes;
}
@property (retain, readwrite) NSColor *bgColor;
@property (copy, readwrite) NSString *string;

- (IBAction)savePDF:(id)sender;

@end
