//
//  DownPaymentView.h
//  HousingLoan
//
//  Created by farthinker on 2/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface DownPaymentView : UIView {
	IBOutlet UIButton *_oneBtn;
	IBOutlet UIButton *_twoBtn;
	IBOutlet UIButton *_threeBtn;
	IBOutlet UIButton *_fourBtn;
	IBOutlet UIButton *_fiveBtn;
	IBOutlet UIButton *_sixBtn;
	IBOutlet UIButton *_sevenBtn;
	IBOutlet UIButton *_eightBtn;
	IBOutlet UIButton *_nineBtn;
	IBOutlet UIButton *_zeroBtn;
	IBOutlet UIButton *_resetBtn;
	IBOutlet UIButton *_delBtn;
	IBOutlet UIButton *_thirtyPercentBtn;
	IBOutlet UIButton *_fourtyPercentBtn;
	IBOutlet UIButton *_fiftyPercentBtn;
	IBOutlet UIButton *_sixtyPercentBtn;
	IBOutlet UIButton *_seventyPercentBtn;
	IBOutlet UIButton *_eightyPercentBtn;
	IBOutlet UIButton *_ninetyPercentBtn;
	NSInteger _totalPayment;
	NSInteger _downPayment;
}

- (IBAction)percentTouchDown:(UIButton *)sender;
- (IBAction)numberTouchDown:(UIButton *)sender;
- (IBAction)resetTouchDown:(UIButton *)sender;
- (IBAction)multiZeroTouchDown:(UIButton *)sender;
- (void)notifyDownPayment;

@end
