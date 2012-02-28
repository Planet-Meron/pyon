//
//  ViewController.h
//  pyon
//
//  Created by 石橋 弦樹 on 11/10/23.
//  Copyright (c) 2011年 横浜国立大学. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AudioToolbox/AudioToolbox.h>
#import <iAd/iAd.h>


@interface ViewController : UIViewController{
    
    SystemSoundID soudID,soundID2,soundID3,soundID4;
    SystemSoundID fail;
    int index;//現在比較する順番
    int level_limit;//レベルの上限
    bool gameflg;
    NSInteger n_max[99];
    NSInteger n[99];
    

    
    

}
@property (weak, nonatomic) IBOutlet UIButton *btn_red;
@property (weak, nonatomic) IBOutlet UIButton *btn_start;
@property (weak, nonatomic) IBOutlet UIButton *btn_yellow;
@property (weak, nonatomic) IBOutlet UIButton *btn_green;
@property (weak, nonatomic) IBOutlet UIButton *btn_blue;
@property (weak, nonatomic) IBOutlet ADBannerView *ad;
@property (weak, nonatomic) IBOutlet UIButton *btn_record;

- (IBAction)btn_blue:(id)sender;
- (IBAction)btn_green:(id)sender;
- (IBAction)btn_red:(id)sender;
- (IBAction)btn_yellow:(id)sender;
- (IBAction)btn_start:(id)sender;
- (void)make_probrem:(int)level;
//広告関係
- (void)moveBannerViewOffscreen;
- (void)moveBannerViewOnscreen;

@end
