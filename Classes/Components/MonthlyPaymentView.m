//
//  MonthlyPaymentView.m
//  HousingLoan
//
//  Created by farthinker on 2/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "MonthlyPaymentView.h"


@implementation MonthlyPaymentView


- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
    if (self) {
		
    }
    return self;
}

- (void)awakeFromNib {
	_loanPeriod.selectedSegmentIndex = -1;
	_rateDiscount.selectedSegmentIndex = -1;
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(resetAll:)
												 name:@"ResetAll" object:nil];
}

- (NSDate *)rateDate {
	return _rateDate;
}

- (void)setRateDate:(NSDate *)rateDate {
	if (_rateDate) {
		[_rateDate release];
		_rateDate = nil;
	}
	_rateDate = [rateDate retain];
	
	NSDateFormatter *fommatter = [[NSDateFormatter alloc] init];
	[fommatter setDateFormat:@"利率执行日期：yyyy年MM月dd日"];
	[_rateDateLabel setText:[fommatter stringFromDate:_rateDate]];
	[fommatter release];
}

- (void)resetAll:(NSNotification *)notification {
	_loanPeriod.selectedSegmentIndex = -1;
	_rateDiscount.selectedSegmentIndex = -1;
}

- (IBAction)loanPeriodChanged:(UISegmentedControl *)sender {
	if (sender.selectedSegmentIndex < 0) {
		return;
	}
	
	NSString *periodText = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
	NSNumber *period = [NSNumber alloc];
	if ([periodText isEqual:@"5年"]) {
		period = [period initWithInteger: 5];
	} else if ([periodText isEqual:@"10年"]) {
		period = [period initWithInteger: 10];
	} else if ([periodText isEqual:@"15年"]) {
		period = [period initWithInteger: 15];
	} else if ([periodText isEqual:@"20年"]) {
		period = [period initWithInteger: 20];
	} else if ([periodText isEqual:@"25年"]) {
		period = [period initWithInteger: 25];
	} else if ([periodText isEqual:@"30年"]) {
		period = [period initWithInteger: 30];
	}
	
	NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:period, @"period", nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"LoanPeriodChanged" object:self userInfo:userInfo];
	[period release];
	[userInfo release];
}

- (IBAction)rateDiscountChanged:(UISegmentedControl *)sender {
	if (sender.selectedSegmentIndex < 0) {
		return;
	}
	
	NSString *discountText = [sender titleForSegmentAtIndex:sender.selectedSegmentIndex];
	NSNumber *discount = [NSNumber alloc];
	if ([discountText isEqual:@"无"]) {
		discount = [discount initWithFloat: 1];
	} else if ([discountText isEqual:@"7折"]) {
		discount = [discount initWithFloat: 0.7];
	} else if ([discountText isEqual:@"8.5折"]) {
		discount = [discount initWithFloat: 0.85];
	} else if ([discountText isEqual:@"1.1倍"]) {
		discount = [discount initWithFloat: 1.1];
	}
	
	NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:discount, @"discount", nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"RateDiscountChanged" object:self userInfo:userInfo];
	[discount release];
	[userInfo release];
}

//- (IBAction)showSummary:(UIButton *)sender {
//	
//}

- (IBAction)resetAllTouchUp:(UIButton *)sender {
	UIAlertView *confirm = [[UIAlertView alloc] initWithTitle:@"您确认要这么做么？" 
													  message:@"您之前的选项会丢失，请谨慎操作。" 
													 delegate:self 
											cancelButtonTitle:@"取消" 
											otherButtonTitles:@"确定", nil];
	[confirm show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex {
	if (buttonIndex == 1) {
		[[NSNotificationCenter defaultCenter] postNotificationName:@"ResetAll" object:self];
	}
}

- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex {
	[alertView release];
}

- (void)dealloc {
    [super dealloc];
}


@end
