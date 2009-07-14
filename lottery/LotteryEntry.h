//
//  LotteryEntry.h
//  lottery
//
//  Created by Chris Mear on 07/02/2009.
//  Copyright 2009 Greenvoice. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface LotteryEntry : NSObject {
	NSCalendarDate *entryDate;
	int firstNumber;
	int secondNumber;
}

- (void)setEntryDate:(NSCalendarDate *)date;
- (NSCalendarDate *)entryDate;
- (int)firstNumber;
- (int)secondNumber;
- (id)initWithEntryDate:(NSCalendarDate *)theDate;

@end
