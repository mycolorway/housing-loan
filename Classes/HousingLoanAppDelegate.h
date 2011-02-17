//
//  HousingLoanAppDelegate.h
//  HousingLoan
//
//  Created by farthinker on 2/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HousingLoanViewController;

@interface HousingLoanAppDelegate : NSObject <UIApplicationDelegate> {
    UIWindow *window;
    HousingLoanViewController *viewController;
}

@property (nonatomic, retain) IBOutlet UIWindow *window;
@property (nonatomic, retain) IBOutlet HousingLoanViewController *viewController;

- (void)initAppDirectories;

@end

