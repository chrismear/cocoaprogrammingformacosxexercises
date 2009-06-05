//
//  Person.h
//  RaiseMan
//
//  Created by Chris Mear on 16/03/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface Person : NSObject {
	NSString *personName;
	float expectedRaise;
}
@property (readwrite, copy) NSString *personName;
@property (readwrite) float expectedRaise;
@end
