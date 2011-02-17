//
//  MonthlyPaymentView.h
//  HousingLoan
//
//  Created by farthinker on 2/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface MonthlyPaymentView : UIView <UIAlertViewDelegate> {
	IBOutlet UISegmentedControl *_loanPeriod;
	IBOutlet UISegmentedControl *_rateDiscount;
	IBOutlet UILabel *_rateDateLabel;
	NSDate *_rateDate;
}

@property (nonatomic, retain) NSDate *rateDate;

- (IBAction)loanPeriodChanged:(UISegmentedControl *)sender;
- (IBAction)rateDiscountChanged:(UISegmentedControl *)sender;
//- (IBAction)showSummary:(UIButton *)sender;
- (IBAction)resetAllTouchUp:(UIButton *)sender;

@end
