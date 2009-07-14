//
//  AppController.h
//  CountCharacters
//
//  Created by Chris Mear on 14/03/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	IBOutlet NSTextField *inputField;
	IBOutlet NSTextField *resultField;
}
- (IBAction)performCount:(id)sender;
@end
