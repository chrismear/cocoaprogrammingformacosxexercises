//
//  AppController.h
//  ImageFun
//
//  Created by Chris Mear on 13/07/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Cocoa/Cocoa.h>
@class StretchView;

@interface AppController : NSObject {
	IBOutlet StretchView *stretchView;
}

- (IBAction)showOpenPanel:(id)sender;

@end
