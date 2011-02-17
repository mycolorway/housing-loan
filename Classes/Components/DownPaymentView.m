//
//  DownPaymentView.m
//  HousingLoan
//
//  Created by farthinker on 2/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "DownPaymentView.h"


@implementation DownPaymentView


- (id)initWithCoder:(NSCoder *)aDecoder {
	self = [super initWithCoder:aDecoder];
    if (self) {

    }
    return self;
}

- (void)awakeFromNib {
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(totalPaymentChanged:)
			 									 name:@"TotalPaymentChanged" object:nil];
}

- (void)percentTouchDown:(UIButton *)sender {
	_downPayment = sender.tag;
	[self notifyDownPayment];
}

- (void)numberTouchDown:(UIButton *)sender {
	NSInteger newPayment = _downPayment;
	newPayment = newPayment * 10 + sender.tag;
	
	if (newPayment >= _totalPayment) {
		return;
	}
	
	_downPayment = newPayment;
	[self notifyDownPayment];
}

- (void)resetTouchDown:(UIButton *)sender {
	_downPayment = 0;
	[self notifyDownPayment];
}

- (void)multiZeroTouchDown:(UIButton *)sender {
	NSInteger newPayment = _downPayment;
	newPayment = newPayment * 10000;
	
	if (newPayment >= _totalPayment) {
		return;
	}
	
	_downPayment = newPayment;
	[self notifyDownPayment];
}

- (void)totalPaymentChanged:(NSNotification *)notification {
	NSNumber *payment = [[notification userInfo] objectForKey:@"payment"];
	_totalPayment = [payment intValue];
	
	NSNumberFormatter *formatter = [[NSNumberFormatter alloc] init];
	[formatter setNumberStyle:NSNumberFormatterDecimalStyle];
	
	NSNumber *thirtyPercent = [NSNumber numberWithInt:round(_totalPayment * 0.3)];
	[_thirtyPercentBtn setTitle:[NSString stringWithFormat:@"3成  %@元", [formatter stringFromNumber:thirtyPercent]] 
					   forState:UIControlStateNormal];
	[_thirtyPercentBtn setTag:[thirtyPercent intValue]];
	
	NSNumber *fourtyPercent = [NSNumber numberWithInt:round(_totalPayment * 0.4)];
	[_fourtyPercentBtn setTitle:[NSString stringWithFormat:@"4成  %@元", [formatter stringFromNumber:fourtyPercent]] 
					   forState:UIControlStateNormal];
	[_fourtyPercentBtn setTag:[fourtyPercent intValue]];
	
	NSNumber *fiftyPercent = [NSNumber numberWithInt:round(_totalPayment * 0.5)];
	[_fiftyPercentBtn setTitle:[NSString stringWithFormat:@"5成  %@元", [formatter stringFromNumber:fiftyPercent]] 
					  forState:UIControlStateNormal];
	[_fiftyPercentBtn setTag:[fiftyPercent intValue]];
	
	NSNumber *sixtyPercent = [NSNumber numberWithInt:round(_totalPayment * 0.6)];
	[_sixtyPercentBtn setTitle:[NSString stringWithFormat:@"6成  %@元", [formatter stringFromNumber:sixtyPercent]] 
					  forState:UIControlStateNormal];
	[_sixtyPercentBtn setTag:[sixtyPercent intValue]];
	
	NSNumber *seventyPercent = [NSNumber numberWithInt:round(_totalPayment * 0.7)];
	[_seventyPercentBtn setTitle:[NSString stringWithFormat:@"7成  %@元", [formatter stringFromNumber:seventyPercent]] 
						forState:UIControlStateNormal];
	[_seventyPercentBtn setTag:[seventyPercent intValue]];
	
	NSNumber *eightyPercent = [NSNumber numberWithInt:round(_totalPayment * 0.8)];
	[_eightyPercentBtn setTitle:[NSString stringWithFormat:@"8成  %@元", [formatter stringFromNumber:eightyPercent]] 
					   forState:UIControlStateNormal];
	[_eightyPercentBtn setTag:[eightyPercent intValue]];
	
	NSNumber *ninetyPercent = [NSNumber numberWithInt:round(_totalPayment * 0.9)];
	[_ninetyPercentBtn setTitle:[NSString stringWithFormat:@"9成  %@元", [formatter stringFromNumber:ninetyPercent]] 
					   forState:UIControlStateNormal];
	[_ninetyPercentBtn setTag:[ninetyPercent intValue]];
}

- (void)notifyDownPayment {
	NSNumber *payment = [[NSNumber alloc] initWithInteger:_downPayment];
	NSDictionary *userInfo = [[NSDictionary alloc] initWithObjectsAndKeys:payment, @"payment", nil];
	[[NSNotificationCenter defaultCenter] postNotificationName:@"DownPaymentChanged" object:self userInfo:userInfo];
	[payment release];
	[userInfo release];
}

- (void)dealloc {
    [super dealloc];
}


@end
