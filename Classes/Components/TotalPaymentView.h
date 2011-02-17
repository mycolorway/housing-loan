//
//  TotalPaymentView.h
//  HousingLoan
//
//  Created by farthinker on 2/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>

@class HouseTypeView, FloorPriceView;

@interface TotalPaymentView : UIView {
	IBOutlet UIScrollView *_houseTypeList;
	IBOutlet UIScrollView *_floorList;
	IBOutlet UILabel *_floorListTitle;
	IBOutlet UILabel *_floorTipLabel;
	HouseTypeView *_selectedType;
	FloorPriceView *_selectedFloor;
}

- (void)loadHouseTypes;
- (void)loadFloors:(NSString *)typeId;

@end
