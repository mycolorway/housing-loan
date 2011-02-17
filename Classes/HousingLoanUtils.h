//
//  HousingLoanUtils.h
//  HousingLoanUtils
//
//  Created by farthinker on 2/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface HousingLoanUtils : NSObject {
	NSString *_documentPath;
	NSString *_typesPath;
}

@property (nonatomic, assign, readonly) NSString *documentPath;
@property (nonatomic, assign, readonly) NSString *typesPath;

+ (HousingLoanUtils *)sharedUtils;

@end
