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
	NSEvent *mouseDownEvent;
	BOOL highlighted;
}
@property (retain, readwrite) NSColor *bgColor;
@property (copy, readwrite) NSString *string;

- (IBAction)savePDF:(id)sender;

- (IBAction)cut:(id)sender;
- (IBAction)copy:(id)sender;
- (IBAction)paste:(id)sender;

@end
