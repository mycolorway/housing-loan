//
//  HousingLoanViewController.h
//  HousingLoan
//
//  Created by farthinker on 2/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TabItemView.h"

@interface HousingLoanViewController : UIViewController {
	IBOutlet TabItemView *_totalPaymentTab;
	IBOutlet TabItemView *_downPaymentTab;
	IBOutlet TabItemView *_monthlyPaymentTab;
	TabItemView *_selectedTab;
	NSInteger _loanPeriod;
	CGFloat _rateDiscount;
	NSDictionary *_loanRateInfo;
}

- (void)calculateMonthlyPayment;

@end

