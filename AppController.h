//
//  AppController.h
//  RaiseMan
//
//  Created by Chris Mear on 05/06/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class PreferenceController;

@interface AppController : NSObject {
	PreferenceController *preferenceController;
}
- (IBAction)showPreferencePanel:(id)sender;
@end
