//
//  Foo.h
//  RandomApp
//
//  Created by Chris Mear on 04/02/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>

@interface Foo : NSObject {
	IBOutlet NSTextField *textField;
}

- (IBAction)seed:(id)sender;
- (IBAction)generate:(id)sender;

@end
