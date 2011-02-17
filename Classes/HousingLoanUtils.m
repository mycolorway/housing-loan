//
//  HousingLoanUtils.m
//  HousingLoanUtils
//
//  Created by farthinker on 2/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "HousingLoanUtils.h"

static HousingLoanUtils *sharedUtils = nil;

@implementation HousingLoanUtils

@synthesize documentPath = _documentPath;
@synthesize typesPath = _typesPath;


+ (HousingLoanUtils *)sharedUtils {
	@synchronized(self)
	{
		if (!sharedUtils)
			sharedUtils = [[self alloc] init];
	}
	return sharedUtils;
}

- (NSString *)documentPath {
	if (!_documentPath) {
		_documentPath = [[NSHomeDirectory() stringByAppendingPathComponent:  @"Documents"] retain];
	}
	return _documentPath;
}

- (NSString *)typesPath {
	if (!_typesPath) {
		_typesPath = [[NSHomeDirectory() stringByAppendingString:  @"/Documents/HouseTypes"] retain];
	}
	return _typesPath;
}

- (void)dealloc {
	[_documentPath release];
	[_typesPath release];
	[super dealloc];
}

@end
