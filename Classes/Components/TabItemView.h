//
//  TabItemView.h
//  HousingLoan
//
//  Created by farthinker on 2/11/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface TabItemView : UIView {
	NSNumber *_amount;
	UIView *_panel;
	Boolean _selected;
	IBOutlet UILabel *_amountLabel;
	IBOutlet UILabel *_titleLabel;
	IBOutlet UIImageView *_bg;
}

@property (nonatomic, assign) NSString *title;
@property (nonatomic, assign) NSNumber *amount;
@property (nonatomic, assign) Boolean selected;
@property (nonatomic, retain) UIView *panel;

@end
