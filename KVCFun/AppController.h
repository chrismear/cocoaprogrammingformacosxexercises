//
//  AppController.h
//  KVCFun
//
//  Created by Chris Mear on 15/03/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface AppController : NSObject {
	int fido;
}
@property(readwrite, assign) int fido;
- (IBAction)incrementFido:(id)sender;
@end
