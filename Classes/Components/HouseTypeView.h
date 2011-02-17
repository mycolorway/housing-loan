//
//  HouseTypeView.h
//  HousingLoan
//
//  Created by farthinker on 2/12/11.
//  Copyright 2011 mycolorway. All rights reserved.
//

#import <UIKit/UIKit.h>


@interface HouseTypeView : UIView {
	NSString *_typeId;
	UIImage *_typeImage;
	NSString *_typeDesc;
	NSInteger _typeArea;
	UIImageView *_typeImageView;
	UILabel *_nameLabel;
	UILabel *_descLabel;
	Boolean _selected;
}

@property (nonatomic, retain) NSString *typeId;
@property (nonatomic, assign) UIImage *typeImage;
@property (nonatomic, assign) NSString *typeName;
@property (nonatomic, retain) NSString *typeDesc;
@property (nonatomic, assign) NSInteger typeArea;
@property (nonatomic, assign) Boolean selected;

@end

