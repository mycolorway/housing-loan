//
//  HousingLoanViewController.m
//  HousingLoan
//
//  Created by farthinker on 2/9/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import "HousingLoanViewController.h"
#import "HousingLoanUtils.h"
#import "MonthlyPaymentView.h"

@implementation HousingLoanViewController


- (void)viewDidLoad {
    [super viewDidLoad];
	
	NSString *documentPath = [[HousingLoanUtils sharedUtils] documentPath];
	NSString *rateInfoPath = [documentPath stringByAppendingPathComponent:@"LoanRate.plist"];
	_loanRateInfo = [[NSDictionary alloc] initWithContentsOfFile:rateInfoPath];
	
	UIViewController *totalLoanController = [[UIViewController alloc] initWithNibName:@"TotalPaymentView" bundle:nil];
	[totalLoanController.view setFrame:CGRectMake(0, 125, 1024, 643)];
	[self.view addSubview:totalLoanController.view];
	_totalPaymentTab.panel = totalLoanController.view;
	[totalLoanController release];
	
	UIViewController *downPaymentController = [[UIViewController alloc] initWithNibName:@"DownPaymentView" bundle:nil];
	[downPaymentController.view setFrame:CGRectMake(0, 125, 1024, 643)];
	[self.view addSubview:downPaymentController.view];
	_downPaymentTab.panel = downPaymentController.view;
	[downPaymentController release];
	
	UIViewController *monthlyPaymentController = [[UIViewController alloc] initWithNibName:@"MonthlyPaymentView" bundle:nil];
	[monthlyPaymentController.view setFrame:CGRectMake(0, 125, 1024, 768)];
	[(MonthlyPaymentView *)monthlyPaymentController.view setRateDate:[_loanRateInfo objectForKey:@"date"]];
	[self.view addSubview:monthlyPaymentController.view];
	_monthlyPaymentTab.panel = monthlyPaymentController.view;
	[monthlyPaymentController release];
	
	_totalPaymentTab.selected = YES;
	_downPaymentTab.selected = NO;
	_monthlyPaymentTab.selected = NO;
	_selectedTab = _totalPaymentTab;
	
	UITapGestureRecognizer *tapGesture1 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabSelected:)];
	[_totalPaymentTab addGestureRecognizer:tapGesture1];
	[tapGesture1 release];
	
	UITapGestureRecognizer *tapGesture2 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabSelected:)];
	[_downPaymentTab addGestureRecognizer:tapGesture2];
	[tapGesture2 release];
	
	UITapGestureRecognizer *tapGesture3 = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tabSelected:)];
	[_monthlyPaymentTab addGestureRecognizer:tapGesture3];
	[tapGesture3 release];
	
	UISwipeGestureRecognizer *swipeGesture1 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwiped:)];
	swipeGesture1.direction = UISwipeGestureRecognizerDirectionLeft;
	[self.view addGestureRecognizer:swipeGesture1];
	
	UISwipeGestureRecognizer *swipeGesture2 = [[UISwipeGestureRecognizer alloc] initWithTarget:self action:@selector(screenSwiped:)];
	swipeGesture2.direction = UISwipeGestureRecognizerDirectionRight;
	[self.view addGestureRecognizer:swipeGesture2];
	
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(totalPaymentChanged:)
												 name:@"TotalPaymentChanged" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(downPaymentChanged:)
												 name:@"DownPaymentChanged" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(loanPeriodChanged:)
												 name:@"LoanPeriodChanged" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(rateDiscountChanged:)
												 name:@"RateDiscountChanged" object:nil];
	
	[[NSNotificationCenter defaultCenter] addObserver:self
											 selector:@selector(resetAll:)
												 name:@"ResetAll" object:nil];
}

- (void)resetAll:(NSNotification *)notification {
	_totalPaymentTab.amount = [NSNumber numberWithInt:0];
	_downPaymentTab.amount = [NSNumber numberWithInt:0];
	_monthlyPaymentTab.amount = [NSNumber numberWithInt:0];
	
	_selectedTab.selected = NO;
	_totalPaymentTab.selected = YES;
	_selectedTab = _totalPaymentTab;
	
	_loanPeriod = 0;
	_rateDiscount = 0;
}

- (void)tabSelected:(id)sender {
	TabItemView *newSelected = (TabItemView *)[sender view];
	if (_selectedTab != newSelected) {
		_selectedTab.selected = NO;
		newSelected.selected = YES;
		_selectedTab = newSelected;
	}
}

- (void)screenSwiped:(id)sender {
	NSArray *tabs = [self.view subviews];
	NSInteger currentIndex = [tabs indexOfObject:_selectedTab];
	NSInteger newIndex;
	
	if ([sender direction] == UISwipeGestureRecognizerDirectionRight) {
		newIndex = currentIndex - 1;
	} else if ([sender direction] == UISwipeGestureRecognizerDirectionLeft) {
		newIndex = currentIndex + 1;
	}
	
	if (newIndex >= [tabs count] || newIndex < 0 || ![[tabs objectAtIndex:newIndex] isKindOfClass:[TabItemView class]]) {
		return;
	}
	
	TabItemView *newSelected = [tabs objectAtIndex:newIndex];
	_selectedTab.selected = NO;
	newSelected.selected = YES;
	_selectedTab = newSelected;
}

- (void)totalPaymentChanged:(NSNotification *)notification {
	NSNumber *payment = [[notification userInfo] objectForKey:@"payment"];
	_totalPaymentTab.amount = payment;
	
	[self calculateMonthlyPayment];
}

- (void)downPaymentChanged:(NSNotification *)notification {
	NSNumber *payment = [[notification userInfo] objectForKey:@"payment"];
	_downPaymentTab.amount = payment;
	
	[self calculateMonthlyPayment];
}

- (void)loanPeriodChanged:(NSNotification *)notification {
	NSNumber *period = [[notification userInfo] objectForKey:@"period"];
	_loanPeriod = [period intValue];
	
	[self calculateMonthlyPayment];
}

- (void)rateDiscountChanged:(NSNotification *)notification {
	NSNumber *discount = [[notification userInfo] objectForKey:@"discount"];
	_rateDiscount = [discount floatValue];
	
	[self calculateMonthlyPayment];
}

- (void)calculateMonthlyPayment {
	CGFloat yearRate;
	CGFloat monthRate;
	NSInteger monthlyPayment;
	NSInteger loanAmount = [_totalPaymentTab.amount intValue] - [_downPaymentTab.amount intValue];
	NSInteger monthCount = _loanPeriod * 12;
	
	if (!(loanAmount && _loanPeriod && _rateDiscount)) {
		return;
	}
	
	if (_loanPeriod == 1) {
		yearRate = [[_loanRateInfo objectForKey:@"rate1"] floatValue] / 100;
	} else if (_loanPeriod <= 3) {
		yearRate = [[_loanRateInfo objectForKey:@"rate3"] floatValue] / 100;
	} else if (_loanPeriod <= 5) {
		yearRate = [[_loanRateInfo objectForKey:@"rate5"] floatValue] / 100;
	} else {
		yearRate = [[_loanRateInfo objectForKey:@"rate5+"] floatValue] / 100;
	}
	
	monthRate = yearRate * _rateDiscount / 12;
	monthlyPayment = loanAmount * monthRate * pow(1 + monthRate, monthCount) / (pow(1 + monthRate, monthCount) - 1);
	_monthlyPaymentTab.amount = [NSNumber numberWithInteger:monthlyPayment];
}

// Override to allow orientations other than the default portrait orientation.
- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation {
	return ((interfaceOrientation == UIInterfaceOrientationLandscapeLeft) 
			|| (interfaceOrientation == UIInterfaceOrientationLandscapeRight));
}

- (void)didReceiveMemoryWarning {
	// Releases the view if it doesn't have a superview.
    [super didReceiveMemoryWarning];
	
	// Release any cached data, images, etc that aren't in use.
}

- (void)viewDidUnload {
	// Release any retained subviews of the main view.
	// e.g. self.myOutlet = nil;
}


- (void)dealloc {
	[_loanRateInfo release];
	
    [super dealloc];
}

@end
