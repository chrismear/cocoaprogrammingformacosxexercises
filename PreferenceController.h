//
//  PreferenceController.h
//  RaiseMan
//
//  Created by Chris Mear on 05/06/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>

extern NSString * const BNRTableBgColorKey;
extern NSString * const BNREmptyDocKey;

@interface PreferenceController : NSWindowController {
	IBOutlet NSColorWell *colorWell;
	IBOutlet NSButton *checkbox;
}
- (IBAction)changeBackgroundColor:(id)sender;
- (IBAction)changeNewEmptyDoc:(id)sender;
- (IBAction)resetToDefaults:(id)sender;
- (NSColor *)tableBgColor;
- (BOOL)emptyDoc;
@end
