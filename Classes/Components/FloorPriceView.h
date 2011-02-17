//
//  FloorPriceView.h
//  HousingLoan
//
//  Created by farthinker on 2/14/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface FloorPriceView : UIView {
	UILabel *_floorLabel;
	UIImageView *_bg;
	NSInteger _floorNum;
	NSInteger _price;
	Boolean _selected;
}

@property (nonatomic, assign) NSInteger floorNum;
@property (nonatomic, assign) NSInteger price;
@property (nonatomic, assign) Boolean selected;

@end
