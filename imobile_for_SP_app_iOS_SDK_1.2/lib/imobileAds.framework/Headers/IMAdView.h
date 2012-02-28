//
//  IMAdView.h
//  imobileAds
//
//  Copyright 2011 i-mobile Co.Ltd. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

#define kIMAdViewDefaultWidth 320
#define kIMAdViewDefaultHeight 50
#define kIMAdViewDefaultFrame (CGRectMake(0,0,kIMAdViewDefaultWidth, kIMAdViewDefaultHeight))

@interface IMAdView : UIView {
@private
    int publisherId_;
    int mediaId_;
    int spotId_;
}

@property (nonatomic,readonly) int publisherId;
@property (nonatomic,readonly) int mediaId;
@property (nonatomic,readonly) int spotId;

- (id)initWithFrame:(CGRect)frame publisherId:(int)pId mediaId:(int)mId spotId:(int)sId;
- (id)initWithFrame:(CGRect)frame publisherId:(int)pId mediaId:(int)mId spotId:(int)sId testMode:(BOOL)isTestMode;

- (void)setWithPublisherId:(int)pId mediaId:(int)mId spotId:(int)sId;
- (void)setWithPublisherId:(int)pId mediaId:(int)mId spotId:(int)sId testMode:(BOOL)isTestMode;

@end
