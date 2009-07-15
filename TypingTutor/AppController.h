//
//  AppController.h
//  TypingTutor
//
//  Created by Chris Mear on 15/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class BigLetterView;

@interface AppController : NSObject {
	// Outlets
	IBOutlet BigLetterView *inLetterView;
	IBOutlet BigLetterView *outLetterView;
	
	// Data
	NSArray *letters;
	int lastIndex;
	
	// Time
	NSTimer *timer;
	int count;
}

- (IBAction)stopGo:(id)sender;
- (void)incrementCount;
- (void)resetCount;
- (void)showAnotherLetter;

@end
